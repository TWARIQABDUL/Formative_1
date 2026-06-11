import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────

class ChatMessage {
  final String id;
  final String senderName;
  final String senderInitials;
  final Color senderColor;
  final String text;
  final String time;
  final bool isMe;
  final bool isFile;
  final String? fileName;
  final String? fileSize;
  Map<String, int> reactions;
  bool isSeen;

  ChatMessage({
    required this.id,
    required this.senderName,
    required this.senderInitials,
    required this.senderColor,
    required this.text,
    required this.time,
    this.isMe = false,
    this.isFile = false,
    this.fileName,
    this.fileSize,
    Map<String, int>? reactions,
    this.isSeen = false,
  }) : reactions = reactions ?? {};
}

class GroupMember {
  final String name;
  final String initials;
  final Color color;
  final bool isOnline;

  const GroupMember({
    required this.name,
    required this.initials,
    required this.color,
    this.isOnline = false,
  });
}

// ─────────────────────────────────────────────
// MOCK DATA
// ─────────────────────────────────────────────

final List<GroupMember> mockMembers = [
  GroupMember(name: 'Teta', initials: 'TK', color: Color(0xFF534AB7), isOnline: true),
  GroupMember(name: 'Aline', initials: 'AM', color: Color(0xFF0F6E56), isOnline: true),
  GroupMember(name: 'Jordan', initials: 'JR', color: Color(0xFF993C1D), isOnline: false),
  GroupMember(name: 'Samuel', initials: 'SK', color: Color(0xFF185FA5), isOnline: true),
];

List<ChatMessage> buildMockMessages() => [
      ChatMessage(
        id: '1',
        senderName: 'Teta K.',
        senderInitials: 'TK',
        senderColor: Color(0xFF534AB7),
        text: 'Hey, did anyone finish the Flutter widget list? I have 23 now 🔥',
        time: '9:12 AM',
        reactions: {'🔥': 3, '👀': 2},
      ),
      ChatMessage(
        id: '2',
        senderName: 'Aline M.',
        senderInitials: 'AM',
        senderColor: Color(0xFF0F6E56),
        text: 'Nice! I\'m still debugging the AnimatedContainer. Anyone have resources?',
        time: '9:14 AM',
      ),
      ChatMessage(
        id: '3',
        senderName: 'Jordan R.',
        senderInitials: 'JR',
        senderColor: Color(0xFF993C1D),
        text: '',
        time: '9:17 AM',
        isFile: true,
        fileName: 'Flutter_Widgets_Guide.pdf',
        fileSize: '2.3 MB · PDF',
      ),
      ChatMessage(
        id: '4',
        senderName: 'Me',
        senderInitials: 'ME',
        senderColor: Color(0xFF185FA5),
        text: 'Thanks Jordan! Downloading now. See you at the session 👍',
        time: '9:19 AM',
        isMe: true,
        isSeen: true,
      ),
    ];

// ─────────────────────────────────────────────
// MAIN SCREEN WIDGET
// ─────────────────────────────────────────────

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  // State variables
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessage> _messages;
  bool _showTyping = true;
  bool _pinnedVisible = true;

  // Theme colors
  static const Color _bg = Color(0xFF0F0F14);
  static const Color _surface = Color(0xFF1E1D28);
  static const Color _border = Color(0xFF2A2A36);
  static const Color _accent = Color(0xFFF5A623);
  static const Color _textPrimary = Color(0xFFF0EFF5);
  static const Color _textSecondary = Color(0xFF9B98B0);
  static const Color _textMuted = Color(0xFF5A5970);
  static const Color _green = Color(0xFF4FC9A3);

  @override
  void initState() {
    super.initState();
    _messages = buildMockMessages();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Sends a new message and appends it to the list
  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderName: 'Me',
        senderInitials: 'ME',
        senderColor: const Color(0xFF185FA5),
        text: text,
        time: _formatNow(),
        isMe: true,
        isSeen: false,
      ));
      _inputController.clear();
      _showTyping = false;
    });

    // Scroll to bottom after sending
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Adds or removes a reaction on a message
  void _toggleReaction(String messageId, String emoji) {
    setState(() {
      final msg = _messages.firstWhere((m) => m.id == messageId);
      if (msg.reactions.containsKey(emoji)) {
        msg.reactions[emoji] = msg.reactions[emoji]! + 1;
      } else {
        msg.reactions[emoji] = 1;
      }
    });
  }

  String _formatNow() {
    final now = DateTime.now();
    final h = now.hour > 12 ? now.hour - 12 : now.hour;
    final m = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildMemberStrip(),
            if (_pinnedVisible) _buildPinnedBanner(),
            Expanded(child: _buildMessageList()),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  // ── HEADER ──────────────────────────────────
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _border, width: 0.5)),
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: _textSecondary, size: 18),
          ),
          const SizedBox(width: 10),

          // Group avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFFF5A623), Color(0xFFE8432D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: const Text('AI',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15)),
          ),
          const SizedBox(width: 10),

          // Group name + online count
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AI Workshop Group',
                    style: TextStyle(
                        color: _textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                          color: _green, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 4),
                    const Text('32 members · 8 online',
                        style:
                            TextStyle(color: _textMuted, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),

          // Action icons
          const Icon(Icons.call_outlined, color: _textSecondary, size: 20),
          const SizedBox(width: 16),
          const Icon(Icons.more_vert_rounded, color: _textSecondary, size: 20),
        ],
      ),
    );
  }

  // ── MEMBER STRIP (horizontal scroll) ────────
  Widget _buildMemberStrip() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        itemCount: mockMembers.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, i) {
          if (i == mockMembers.length) {
            // "+more" pill
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _border, width: 0.5),
              ),
              alignment: Alignment.center,
              child: const Text('+24 more',
                  style: TextStyle(color: _textMuted, fontSize: 10)),
            );
          }
          final m = mockMembers[i];
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _border, width: 0.5),
            ),
            child: Row(
              children: [
                // Member avatar circle with online dot
                Stack(
                  children: [
                    _miniAvatar(m.initials, m.color, 20),
                    if (m.isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _green,
                            shape: BoxShape.circle,
                            border: Border.all(color: _bg, width: 1.5),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 5),
                Text(m.name,
                    style: const TextStyle(
                        color: _textSecondary, fontSize: 10)),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── PINNED BANNER ────────────────────────────
  Widget _buildPinnedBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1928),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        border: const Border(
          left: BorderSide(color: _accent, width: 2),
          top: BorderSide(color: _border, width: 0.5),
          right: BorderSide(color: _border, width: 0.5),
          bottom: BorderSide(color: _border, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.push_pin_outlined, color: _accent, size: 14),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Session tomorrow 8am — Innovation Lab B. Bring your laptop.',
              style: TextStyle(color: _textSecondary, fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Dismiss the pinned banner
          GestureDetector(
            onTap: () => setState(() => _pinnedVisible = false),
            child: const Icon(Icons.close_rounded,
                color: _textMuted, size: 14),
          ),
        ],
      ),
    );
  }

  // ── MESSAGE LIST ─────────────────────────────
  Widget _buildMessageList() {
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      itemCount: _messages.length + (_showTyping ? 2 : 1),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        // Date divider at the top
        if (i == 0) return _buildDateDivider('Today · June 10');

        final msgIndex = i - 1;

        // Typing indicator at the end
        if (_showTyping && msgIndex == _messages.length) {
          return _buildTypingIndicator();
        }

        final msg = _messages[msgIndex];
        return msg.isFile ? _buildFileMessage(msg) : _buildTextMessage(msg);
      },
    );
  }

  Widget _buildDateDivider(String label) {
    return Row(
      children: [
        const Expanded(child: Divider(color: _border, thickness: 0.5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(label,
              style: const TextStyle(
                  color: _textMuted,
                  fontSize: 10,
                  letterSpacing: 0.05)),
        ),
        const Expanded(child: Divider(color: _border, thickness: 0.5)),
      ],
    );
  }

  Widget _buildTextMessage(ChatMessage msg) {
    return Column(
      crossAxisAlignment:
          msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              msg.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Sender avatar (left side only)
            if (!msg.isMe) ...[
              _miniAvatar(msg.senderInitials, msg.senderColor, 26),
              const SizedBox(width: 7),
            ],

            // Bubble
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 9),
                decoration: BoxDecoration(
                  color: msg.isMe ? _accent : _surface,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(14),
                    topRight: const Radius.circular(14),
                    bottomLeft: Radius.circular(msg.isMe ? 14 : 4),
                    bottomRight: Radius.circular(msg.isMe ? 4 : 14),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Show sender name for group messages
                    if (!msg.isMe)
                      Text(msg.senderName,
                          style: TextStyle(
                              color: msg.senderColor.withOpacity(0.9),
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    if (!msg.isMe) const SizedBox(height: 3),
                    Text(msg.text,
                        style: TextStyle(
                            color: msg.isMe
                                ? const Color(0xFF1A0F00)
                                : const Color(0xFFD8D7E5),
                            fontSize: 12,
                            height: 1.5)),
                    const SizedBox(height: 4),
                    // Time + seen indicators
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(msg.time,
                            style: TextStyle(
                                color: msg.isMe
                                    ? const Color(0xFF7A5010)
                                    : _textMuted,
                                fontSize: 9)),
                        if (msg.isMe) ...[
                          const SizedBox(width: 4),
                          Icon(
                            msg.isSeen
                                ? Icons.done_all_rounded
                                : Icons.done_rounded,
                            size: 12,
                            color: msg.isSeen ? _green : _textMuted,
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
              ),
            ),

            if (msg.isMe) ...[
              const SizedBox(width: 7),
              _miniAvatar(msg.senderInitials, msg.senderColor, 26),
            ],
          ],
        ),

        // Reaction pills (shown below bubble)
        if (msg.reactions.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              top: 5,
              left: msg.isMe ? 0 : 33,
              right: msg.isMe ? 33 : 0,
            ),
            child: Wrap(
              spacing: 5,
              children: msg.reactions.entries
                  .map((e) => _buildReactionPill(msg.id, e.key, e.value))
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildFileMessage(ChatMessage msg) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _miniAvatar(msg.senderInitials, msg.senderColor, 26),
        const SizedBox(width: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 210,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1928),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _border, width: 0.5),
              ),
              child: Row(
                children: [
                  // File icon container
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B1D00),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Icon(Icons.picture_as_pdf_rounded,
                        color: _accent, size: 18),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(msg.fileName ?? '',
                            style: const TextStyle(
                                color: Color(0xFFD8D7E5),
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 2),
                        Text(msg.fileSize ?? '',
                            style: const TextStyle(
                                color: _textMuted, fontSize: 10)),
                      ],
                    ),
                  ),
                  const Icon(Icons.download_rounded,
                      color: _textSecondary, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Text('${msg.senderName} · ${msg.time}',
                style:
                    const TextStyle(color: _textMuted, fontSize: 10)),
          ],
        ),
      ],
    );
  }

  Widget _buildReactionPill(String msgId, String emoji, int count) {
    return GestureDetector(
      onTap: () => _toggleReaction(msgId, emoji),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFF2B1D00),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _accent, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 11)),
            const SizedBox(width: 3),
            Text('$count',
                style:
                    const TextStyle(color: _accent, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      children: [
        _miniAvatar('TK', const Color(0xFF534AB7), 26),
        const SizedBox(width: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                  bottomLeft: Radius.circular(4),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  3,
                  (i) => _AnimatedDot(delay: Duration(milliseconds: i * 200)),
                ),
              ),
            ),
            const SizedBox(height: 3),
            const Text('Teta is typing…',
                style: TextStyle(color: _textMuted, fontSize: 10)),
          ],
        ),
      ],
    );
  }

  // ── INPUT BAR ────────────────────────────────
  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _border, width: 0.5)),
      ),
      child: Row(
        children: [
          // Emoji
          const Icon(Icons.emoji_emotions_outlined,
              color: _textSecondary, size: 22),
          const SizedBox(width: 8),

          // Text input
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: _border, width: 0.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      style: const TextStyle(
                          color: _textPrimary, fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: 'Message the group…',
                        hintStyle:
                            TextStyle(color: _textMuted, fontSize: 13),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const Icon(Icons.attach_file_rounded,
                      color: _textSecondary, size: 18),
                  const SizedBox(width: 8),
                  const Icon(Icons.camera_alt_outlined,
                      color: _textSecondary, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Send button
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: _accent, shape: BoxShape.circle),
              child: const Icon(Icons.send_rounded,
                  color: Color(0xFF1A0F00), size: 18),
            ),
          ),
        ],
      ),
    );
  }

  // ── HELPERS ──────────────────────────────────
  Widget _miniAvatar(String initials, Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      alignment: Alignment.center,
      child: Text(initials,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: size * 0.38)),
    );
  }
}

// ─────────────────────────────────────────────
// ANIMATED TYPING DOT
// ─────────────────────────────────────────────

class _AnimatedDot extends StatefulWidget {
  final Duration delay;
  const _AnimatedDot({required this.delay});

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0, end: -5).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

    // Stagger by delay
    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        transform: Matrix4.translationValues(0, _anim.value, 0),
        child: Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
              color: Color(0xFF5A5970), shape: BoxShape.circle),
        ),
      ),
    );
  }
}