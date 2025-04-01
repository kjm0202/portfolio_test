import 'package:flutter/material.dart';
import 'package:portfolio/portfolio_data.dart';
import 'package:portfolio/theme_provider.dart';
import 'package:portfolio/home_screen.dart';
import 'package:portfolio/project_detail_screen.dart';
import 'package:portfolio/responsive_layout.dart';
import 'package:portfolio/section_widgets.dart';
import 'package:provider/provider.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ProfileData _profileData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _profileData = ProfileData.sampleData();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isDesktop = ResponsiveLayout.isDesktop(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _profileData.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
            tooltip:
                themeProvider.isDarkMode
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
          ),
          if (!isMobile) const SizedBox(width: 8),
        ],
        bottom:
            isMobile
                ? null
                : TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: const [
                    Tab(icon: Icon(Icons.home), text: 'Home'),
                    Tab(icon: Icon(Icons.work), text: 'Experience'),
                    Tab(icon: Icon(Icons.code), text: 'Projects'),
                    Tab(icon: Icon(Icons.school), text: 'Education'),
                    Tab(icon: Icon(Icons.contact_mail), text: 'Contact'),
                  ],
                ),
      ),
      drawer: isMobile ? Drawer(child: _buildDrawer()) : null,
      body: ResponsiveLayout(
        mobileBody: _buildMobileBody(),
        tabletBody: _buildTabletBody(),
        desktopBody: _buildDesktopBody(),
      ),
      bottomNavigationBar:
          isMobile
              ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _tabController.index,
                onTap: (index) {
                  setState(() {
                    _tabController.index = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.work),
                    label: 'Experience',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.code),
                    label: 'Projects',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'Education',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.contact_mail),
                    label: 'Contact',
                  ),
                ],
              )
              : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Download resume as PDF
        },
        tooltip: 'Download Resume',
        child: const Icon(Icons.download),
      ),
    );
  }

  Widget _buildDrawer() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(_profileData.photoUrl),
            onBackgroundImageError: (exception, stackTrace) {},
          ),
          accountName: Text(_profileData.name),
          accountEmail: Text(_profileData.tagline),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            _tabController.animateTo(0);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.work),
          title: const Text('Experience'),
          onTap: () {
            _tabController.animateTo(1);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.code),
          title: const Text('Projects'),
          onTap: () {
            _tabController.animateTo(2);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.school),
          title: const Text('Education'),
          onTap: () {
            _tabController.animateTo(3);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.contact_mail),
          title: const Text('Contact'),
          onTap: () {
            _tabController.animateTo(4);
            Navigator.pop(context);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.download),
          title: const Text('Download Resume'),
          onTap: () {
            // Implement PDF resume download
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildMobileBody() {
    return TabBarView(
      controller: _tabController,
      children: [
        HomeScreen(profileData: _profileData),
        _buildExperienceTab(),
        _buildProjectsTab(),
        _buildEducationTab(),
        _buildContactTab(),
      ],
    );
  }

  Widget _buildTabletBody() {
    return TabBarView(
      controller: _tabController,
      children: [
        HomeScreen(profileData: _profileData),
        _buildExperienceTab(),
        _buildProjectsTab(),
        _buildEducationTab(),
        _buildContactTab(),
      ],
    );
  }

  Widget _buildDesktopBody() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TabBarView(
            controller: _tabController,
            children: [
              HomeScreen(profileData: _profileData),
              _buildExperienceTab(),
              _buildProjectsTab(),
              _buildEducationTab(),
              _buildContactTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Work Experience', icon: Icons.work),
          const SizedBox(height: 16),
          ..._profileData.experiences.map(
            (experience) => ExperienceCard(experience: experience),
          ),
          const SizedBox(height: 24),
          const SectionTitle(title: 'Skills', icon: Icons.bar_chart),
          const SizedBox(height: 16),
          SkillsChart(skills: _profileData.skills),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Projects', icon: Icons.code),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                // Grid layout for larger screens
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _profileData.projects.length,
                  itemBuilder: (context, index) {
                    final project = _profileData.projects[index];
                    return ProjectCard(
                      project: project,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    ProjectDetailScreen(project: project),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                // List layout for smaller screens
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _profileData.projects.length,
                  itemBuilder: (context, index) {
                    final project = _profileData.projects[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ProjectCard(
                        project: project,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ProjectDetailScreen(project: project),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEducationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Education', icon: Icons.school),
          const SizedBox(height: 16),
          ..._profileData.education.map(
            (education) => EducationCard(education: education),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Contact Me', icon: Icons.contact_mail),
          const SizedBox(height: 16),
          ContactInfo(contact: _profileData.contact),
          const SizedBox(height: 32),
          const SectionTitle(title: 'Send a Message', icon: Icons.message),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Your Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.subject),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Your Message',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.message),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text('SEND MESSAGE'),
                    onPressed: () {
                      // Implement message sending
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Message feature coming soon!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
