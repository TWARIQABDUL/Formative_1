import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────

class UserProfile {
  final String fullName;
  final String handle;
  final String campus;
  final String initials;
  final String bio;
  final List<String> tags;
  final int eventsCount;
  final int communitiesCount;
  final int connectionsCount;
  final String role; // e.g. "LEADER", "STUDENT"
  final bool isVerified;
  final List<ParchmentBadge> badges;
  final List<Connection> connections;
  final List<ActivityItem> recentActivity;

  const UserProfile({
    required this.fullName,
    required this.handle,
    required this.campus,
    required this.initials,
    required this.bio,
    required this.tags,
    required this.eventsCount,
    required this.communitiesCount,
    required this.connectionsCount,
    required this.role,
    required this.isVerified,
    required this.badges,
    required this.connections,
    required this.recentActivity,
  });
}

class ParchmentBadge {
  final String name;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const ParchmentBadge({
    required this.name,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });
}

class Connection {
  final String name;
  final String initials;
  final Color color;

  const Connection({
    required this.name,
    required this.initials,
    required this.color,
  });
}

class ActivityItem {
  final String action; // e.g. "RSVP'd", "Joined"
  final String detail;
  final String time;
  final Color dotColor;

  const ActivityItem({
    required this.action,
    required this.detail,
    required this.time,
    required this.dotColor,
  });
}

// ─────────────────────────────────────────────
// MOCK PROFILE DATA
// ─────────────────────────────────────────────

final UserProfile mockProfile = UserProfile(
  fullName: 'Teta Ketsia',
  handle: '@teta.k',
  campus: 'Kigali Campus, Rwanda',
  initials: 'TK',
  bio: 'Software Engineering student · Building for Africa 🌍 · Flutter dev · Tech & Social Impact enthusiast',
  tags: ['Flutter Dev', 'AI & ML', 'Entrepreneurship', 'Year 2'],
  eventsCount: 23,
  communitiesCount: 5,
  connectionsCount: 87,
  role: 'LEADER',
  isVerified: true,
  badges: [
    ParchmentBadge(
      name: 'Hackathon Winner',
      icon: Icons.emoji_events_rounded,
      bgColor: Color(0xFF2B1D00),
      iconColor: Color(0xFFF5A623),
    ),
    ParchmentBadge(
      name: 'Sustainability',
      icon: Icons.eco_rounded,
      bgColor: Color(0xFF0A1F14),
      iconColor: Color(0xFF4FC9A3),
    ),
    ParchmentBadge(
      name: 'Community Lead',
      icon: Icons.groups_rounded,
      bgColor: Color(0xFF1A1040),
      iconColor: Color(0xFFAFA9EC),
    ),
    ParchmentBadge(
      name: 'Dev Sprint',
      icon: Icons.code_rounded,
      bgColor: Color(0xFF1A0820),
      iconColor: Color(0xFFED93B1),
    ),
  ],
  connections: [
    Connection(name: 'Aline', initials: 'AM', color: Color(0xFF0F6E56)),
    Connection(name: 'Jordan', initials: 'JR', color: Color(0xFF993C1D)),
    Connection(name: 'Samuel', initials: 'SK', color: Color(0xFF185FA5)),
    Connection(name: 'Nadia', initials: 'NM', color: Color(0xFF993556)),
    Connection(name: 'Emeka', initials: 'EO', color: Color(0xFF3B6D11)),
  ],
  recentActivity: [
    ActivityItem(
      action: 'RSVP\'d',
      detail: 'to AI for Social Impact Workshop · Kigali Campus',
      time: '2h ago',
      dotColor: Color(0xFFF5A623),
    ),
    ActivityItem(
      action: 'Joined',
      detail: 'Tech & Innovation Hub community',
      time: 'Yesterday',
      dotColor: Color(0xFF4FC9A3),
    ),
    ActivityItem(
      action: 'Posted',
      detail: 'a new opportunity: Flutter Peer Study Group',
      time: 'Jun 8',
      dotColor: Color(0xFFAFA9EC),
    ),
  ],
);

// ─────────────────────────────────────────────
// MAIN SCREEN WIDGET
// ─────────────────────────────────────────────

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Which tab is selected: 0=Posts, 1=Saved, 2=Activity
  int _selectedTab = 2;

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCoverAndAvatar(),
                    _buildProfileInfo(),
                    _buildStatsRow(),
                    _buildTabRow(),
                    _buildTabContent(),
                  ],
                ),
              ),
            ),
            _buildNavBar(),
          ],
        ),
      ),
    );
  }

  // ── TOP BAR ──────────────────────────────────
  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _border, width: 0.5)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: _textSecondary, size: 18),
          ),
          const Expanded(
            child: Text(
              'My Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const Icon(Icons.settings_outlined,
              color: _textSecondary, size: 20),
        ],
      ),
    );
  }

  // ── COVER + AVATAR ───────────────────────────
  Widget _buildCoverAndAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Cover gradient
        Container(
          height: 100,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF5A623),
                Color(0xFFE8432D),
                Color(0xFF1A0050),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // Campus label on the cover
          child: const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 12, bottom: 8),
              child: Text(
                'ALU · Kigali Campus',
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: 9,
                    letterSpacing: 0.05),
              ),
            ),
          ),
        ),

        // Avatar + action buttons row
        Positioned(
          top: 68,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Avatar with border
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: _bg, width: 3),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF534AB7), Color(0xFFAFA9EC)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'TK',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22),
                  ),
                ),
                const SizedBox(width: 8),

                // Role badge + verified
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2B1D00),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: _accent, width: 0.5),
                          ),
                          child: const Text(
                            'LEADER',
                            style: TextStyle(
                                color: _accent,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.05),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified_rounded,
                            color: _green, size: 14),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // Action buttons
                Row(
                  children: [
                    _outlineButton(
                      icon: Icons.share_outlined,
                      label: null,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    _outlineButton(
                      icon: null,
                      label: 'Edit profile',
                      onTap: () {},
                      highlight: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Space holder so Stack has correct height
        const SizedBox(height: 176),
      ],
    );
  }

  Widget _outlineButton({
    IconData? icon,
    String? label,
    required VoidCallback onTap,
    bool highlight = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: label != null ? 12 : 8,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          border: Border.all(
              color: highlight ? _accent : _border, width: 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(icon,
                  color: highlight ? _accent : _textSecondary, size: 14),
            if (label != null)
              Text(label,
                  style: TextStyle(
                      color: highlight ? _accent : _textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // ── PROFILE INFO ─────────────────────────────
  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          const Text(
            'Teta Ketsia',
            style: TextStyle(
                color: _textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),

          // Handle + location
          const Text(
            '@teta.k · Kigali Campus, Rwanda',
            style: TextStyle(color: _textMuted, fontSize: 12),
          ),
          const SizedBox(height: 7),

          // Bio
          Text(
            mockProfile.bio,
            style: const TextStyle(
                color: _textSecondary, fontSize: 12, height: 1.55),
          ),
          const SizedBox(height: 9),

          // Interest tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: mockProfile.tags.map((tag) {
              final isHighlight = tag == 'Flutter Dev';
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isHighlight
                      ? const Color(0xFF2B1D00)
                      : _surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isHighlight ? _accent : _border,
                    width: 0.5,
                  ),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                      color: isHighlight ? _accent : _textSecondary,
                      fontSize: 10),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // ── STATS ROW ────────────────────────────────
  Widget _buildStatsRow() {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: _border, width: 0.5)),
      ),
      child: Row(
        children: [
          _statCell(mockProfile.eventsCount.toString(), 'Events'),
          _divider(),
          _statCell(
              mockProfile.communitiesCount.toString(), 'Communities'),
          _divider(),
          _statCell(
              mockProfile.connectionsCount.toString(), 'Connections'),
        ],
      ),
    );
  }

  Widget _statCell(String value, String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    color: _textMuted,
                    fontSize: 10,
                    letterSpacing: 0.03)),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(width: 0.5, height: 40, color: _border);
  }

  // ── TABS ─────────────────────────────────────
  Widget _buildTabRow() {
    final tabs = ['Posts', 'Saved', 'Activity'];
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _border, width: 0.5)),
      ),
      child: Row(
        children: tabs.asMap().entries.map((e) {
          final selected = e.key == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = e.key),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selected ? _accent : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  e.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected ? _accent : _textMuted,
                    fontSize: 12,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    // Activity tab (index 2)
    if (_selectedTab == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Parchment badges', 'View all'),
          _buildBadgeGrid(),
          _sectionHeader('Connections', 'See all 87'),
          _buildConnectionStrip(),
          _sectionHeader('Recent activity', null),
          _buildActivityList(),
          const SizedBox(height: 16),
        ],
      );
    }

    // Posts / Saved — empty state
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(
            _selectedTab == 0
                ? Icons.post_add_rounded
                : Icons.bookmark_outline_rounded,
            color: _textMuted,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(
            _selectedTab == 0
                ? 'No posts yet'
                : 'Nothing saved yet',
            style: const TextStyle(color: _textMuted, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, String? action) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          if (action != null)
            Text(action,
                style:
                    const TextStyle(color: _accent, fontSize: 11)),
        ],
      ),
    );
  }

  // ── BADGE GRID ───────────────────────────────
  Widget _buildBadgeGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: mockProfile.badges.map((b) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _border, width: 0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: b.bgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(b.icon, color: b.iconColor, size: 18),
                ),
                const SizedBox(height: 5),
                Text(
                  b.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: _textSecondary, fontSize: 9, height: 1.3),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── CONNECTION STRIP ─────────────────────────
  Widget _buildConnectionStrip() {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: mockProfile.connections.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, i) {
          final c = mockProfile.connections[i];
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _border, width: 0.5),
            ),
            child: Row(
              children: [
                _miniAvatar(c.initials, c.color, 24),
                const SizedBox(width: 6),
                Text(c.name,
                    style: const TextStyle(
                        color: _textSecondary, fontSize: 11)),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── ACTIVITY LIST ────────────────────────────
  Widget _buildActivityList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: mockProfile.recentActivity.map((a) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _border, width: 0.5),
            ),
            child: Row(
              children: [
                // Colored dot showing activity type
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: a.dotColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${a.action} ',
                          style: const TextStyle(
                              color: Color(0xFFD8D7E5),
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: a.detail,
                          style: const TextStyle(
                              color: _textSecondary, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(a.time,
                    style: const TextStyle(
                        color: _textMuted, fontSize: 10)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── BOTTOM NAV ───────────────────────────────
  Widget _buildNavBar() {
    // Nav items: icon + which index is "active"
    final items = [
      Icons.home_outlined,
      Icons.search_rounded,
      Icons.add_circle_outline_rounded,
      Icons.chat_bubble_outline_rounded,
      Icons.account_circle_outlined,
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _border, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((e) {
          final isActive = e.key == 4; // Profile is active
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(e.value,
                  color: isActive ? _accent : _textMuted, size: 22),
              if (isActive)
                Container(
                  margin: const EdgeInsets.only(top: 3),
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                      color: _accent, shape: BoxShape.circle),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ── HELPER ───────────────────────────────────
  Widget _miniAvatar(String initials, Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: size * 0.38),
      ),
    );
  }
}