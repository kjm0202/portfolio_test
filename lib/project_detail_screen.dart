import 'package:flutter/material.dart';
import 'package:portfolio/portfolio_data.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({Key? key, required this.project})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildProjectInfo(context),
                  const SizedBox(height: 24),
                  _buildTechnologies(context),
                  const SizedBox(height: 24),
                  _buildProjectLinks(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          project.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3.0,
                color: Color.fromARGB(150, 0, 0, 0),
              ),
            ],
          ),
        ),
        background: Hero(
          tag: 'project-${project.title}',
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                project.imageUrl,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.2),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Theme.of(context).colorScheme.primary,
                          size: 40,
                        ),
                      ),
                    ),
              ),
              // Gradient overlay for better text visibility
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.link),
          tooltip: 'Open Project Link',
          onPressed: () {
            // Implement URL launcher
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          tooltip: 'Share Project',
          onPressed: () {
            // Implement share functionality
          },
        ),
      ],
    );
  }

  Widget _buildProjectInfo(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: 1.0,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project Overview',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                project.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              // Sample detailed description - in a real app, this would come from the project data
              Text(
                'This project was created to solve the problem of ${project.title.toLowerCase()} management. '
                'It features a clean, intuitive interface designed with user experience in mind. '
                'The app was developed using modern architecture patterns and best practices in mobile development.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Key Features:',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Sample features - in a real app, these would come from the project data
              _buildFeatureItem(
                context,
                'Responsive design that works across all devices',
              ),
              _buildFeatureItem(
                context,
                'Intuitive and user-friendly interface',
              ),
              _buildFeatureItem(
                context,
                'Dark mode support for better visibility',
              ),
              _buildFeatureItem(
                context,
                'Offline capabilities for uninterrupted usage',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 18,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(feature)),
        ],
      ),
    );
  }

  Widget _buildTechnologies(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Technologies Used',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  project.technologies
                      .map((tech) => _buildTechnologyChip(context, tech))
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnologyChip(BuildContext context, String technology) {
    return Chip(
      label: Text(
        technology,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget _buildProjectLinks(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Links',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.code, color: Colors.white),
              ),
              title: const Text('Source Code'),
              subtitle: Text(project.linkUrl),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                // Implement URL launcher to open the project link
              },
            ),
            const Divider(),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: const Icon(Icons.public, color: Colors.white),
              ),
              title: const Text('Live Demo'),
              subtitle: const Text('https://example.com/demo'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                // Implement URL launcher to open the demo link
              },
            ),
          ],
        ),
      ),
    );
  }
}
