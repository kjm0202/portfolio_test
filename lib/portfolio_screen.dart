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

class _PortfolioScreenState extends State<PortfolioScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ProfileData _profileData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _profileData = ProfileData.sampleData();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
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
      appBar: isMobile ? _buildMobileAppBar(themeProvider) : null,
      drawer: isMobile
          ? Drawer(child: _buildNavigationPanel(isMobile: true))
          : null,
      body: ResponsiveLayout(
        mobileBody: _buildMobileBody(),
        tabletBody: _buildTabletBody(),
        desktopBody: _buildDesktopBody(themeProvider),
      ),
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  _tabController.animateTo(index);
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Experience'),
                BottomNavigationBarItem(icon: Icon(Icons.code), label: 'Projects'),
                BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Education'),
                BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Contact'),
              ],
            )
          : null,
      floatingActionButton: isMobile ? FloatingActionButton(
        onPressed: () {
          // Download resume as PDF
        },
        tooltip: 'Download Resume',
        child: const Icon(Icons.download),
      ) : null,
    );
  }

  AppBar _buildMobileAppBar(ThemeProvider themeProvider) {
    return AppBar(
      title: Text(
        _profileData.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
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
          tooltip: themeProvider.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        ),
      ],
    );
  }

  Widget _buildNavigationPanel({bool isMobile = false}) {
    final navItems = [
      {'icon': Icons.home, 'label': 'Home', 'index': 0},
      {'icon': Icons.person, 'label': 'About', 'index': 0},
      {'icon': Icons.work, 'label': 'Experience', 'index': 1},
      {'icon': Icons.code, 'label': 'Projects', 'index': 2},
      {'icon': Icons.school, 'label': 'Education', 'index': 3},
      {'icon': Icons.contact_mail, 'label': 'Contact', 'index': 4},
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Text(
                    _profileData.name.substring(0, 1),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              if (!isMobile) ...[  
                const SizedBox(height: 12),
                Text(
                  _profileData.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  _profileData.tagline.split(' & ')[0],
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: navItems.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = navItems[index];
              final isSelected = _currentIndex == item['index'];
              
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                ),
                child: ListTile(
                  leading: Icon(
                    item['icon'] as IconData,
                    color: isSelected 
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    item['label'] as String,
                    style: TextStyle(
                      color: isSelected 
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _currentIndex = item['index'] as int;
                      _tabController.animateTo(_currentIndex);
                    });
                    if (isMobile) {
                      Navigator.pop(context);
                    }
                  },
                ),
              );
            },
          ),
        ),
        if (!isMobile) ...[  
          const Divider(),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Resume'),
            onTap: () {
              // Download resume
            },
          ),
          Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
            return ListTile(
              leading: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              title: Text(
                themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
              ),
              onTap: () {
                themeProvider.toggleTheme();
              },
            );
          }),
          const SizedBox(height: 20),
        ],
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

  Widget _buildDesktopBody(ThemeProvider themeProvider) {
    return Row(
      children: [
        // Navigation Sidebar
        Container(
          width: 240,
          color: Theme.of(context).colorScheme.surface,
          child: _buildNavigationPanel(),
        ),
        // Main Content Area
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              HomeScreen(profileData: _profileData, isDesktop: true),
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
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: const SectionTitle(
              title: 'Work Experience',
              icon: Icons.work,
            ),
          ),
          const SizedBox(height: 16),
          ..._profileData.experiences.map((experience) => ExperienceCard(
                experience: experience,
              )),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            child: const SectionTitle(
              title: 'Skills',
              icon: Icons.bar_chart,
            ),
          ),
          const SizedBox(height: 16),
          SkillsChart(skills: _profileData.skills),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: const SectionTitle(
              title: 'Projects',
              icon: Icons.code,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1200 ? 3 : (constraints.maxWidth > 700 ? 2 : 1);
              
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
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
                          builder: (context) => ProjectDetailScreen(project: project),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEducationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: const SectionTitle(
              title: 'Education',
              icon: Icons.school,
            ),
          ),
          const SizedBox(height: 16),
          ..._profileData.education.map((education) => EducationCard(
                education: education,
              )),
        ],
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: const SectionTitle(
              title: 'Contact Me',
              icon: Icons.contact_mail,
            ),
          ),
          const SizedBox(height: 16),
          ContactInfo(contact: _profileData.contact),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            child: const SectionTitle(
              title: 'Send a Message',
              icon: Icons.message,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Your Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.subject),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Your Message',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 80),
                          child: Icon(Icons.message),
                        ),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}