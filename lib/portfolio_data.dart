class ProfileData {
  final String name;
  final String tagline;
  final String photoUrl;
  final String bio;
  final List<String> expertise;
  final List<Experience> experiences;
  final List<Project> projects;
  final List<Skill> skills;
  final List<Education> education;
  final Contact contact;

  ProfileData({
    required this.name,
    required this.tagline,
    required this.photoUrl,
    required this.bio,
    required this.expertise,
    required this.experiences,
    required this.projects,
    required this.skills,
    required this.education,
    required this.contact,
  });

  // Sample profile data
  static ProfileData sampleData() {
    return ProfileData(
      name: 'Jane Doe',
      tagline: 'Flutter Developer & UI/UX Enthusiast',
      photoUrl: 'https://via.placeholder.com/150',
      bio:
          'Passionate Flutter developer with 5+ years of experience creating beautiful, responsive applications. Specialized in crafting engaging user experiences and optimizing app performance.',
      expertise: [
        'Flutter Development',
        'UI/UX Design',
        'Mobile App Architecture',
        'Cross-Platform Development',
      ],
      experiences: [
        Experience(
          company: 'Tech Innovations Inc.',
          role: 'Senior Flutter Developer',
          duration: 'Jan 2021 - Present',
          description:
              'Lead developer for multiple high-profile mobile applications. Implemented complex UI designs and optimized app performance.',
          achievements: [
            'Reduced app loading time by 40%',
            'Implemented CI/CD pipeline',
            'Mentored junior developers',
          ],
        ),
        Experience(
          company: 'Mobile Solutions Ltd',
          role: 'Flutter Developer',
          duration: 'Mar 2019 - Dec 2020',
          description:
              'Developed and maintained multiple Flutter applications for clients across various industries.',
          achievements: [
            'Created custom animations and transitions',
            'Integrated RESTful APIs',
            'Implemented state management solutions',
          ],
        ),
        Experience(
          company: 'StartUp Ventures',
          role: 'Junior Developer',
          duration: 'Jun 2017 - Feb 2019',
          description:
              'Worked on front-end development for mobile and web applications.',
          achievements: [
            'Contributed to UI component library',
            'Built responsive web designs',
            'Learned mobile development fundamentals',
          ],
        ),
      ],
      projects: [
        Project(
          title: 'Health Tracker App',
          description:
              'A comprehensive health and fitness tracking application built with Flutter.',
          imageUrl: 'https://via.placeholder.com/300x200',
          technologies: ['Flutter', 'Provider', 'Firebase', 'RESTful API'],
          linkUrl: 'https://github.com/username/health-tracker',
        ),
        Project(
          title: 'E-commerce Platform',
          description:
              'Full-featured e-commerce application with payment integration and order tracking.',
          imageUrl: 'https://via.placeholder.com/300x200',
          technologies: ['Flutter', 'Bloc', 'Stripe API', 'Firebase'],
          linkUrl: 'https://github.com/username/e-commerce',
        ),
        Project(
          title: 'Weather Forecast App',
          description:
              'Beautiful weather app with animated transitions and accurate forecasts.',
          imageUrl: 'https://via.placeholder.com/300x200',
          technologies: ['Flutter', 'Animations', 'Weather API', 'Geolocation'],
          linkUrl: 'https://github.com/username/weather-app',
        ),
      ],
      skills: [
        Skill(name: 'Flutter', level: 0.9),
        Skill(name: 'Dart', level: 0.85),
        Skill(name: 'UI/UX Design', level: 0.8),
        Skill(name: 'Firebase', level: 0.75),
        Skill(name: 'RESTful APIs', level: 0.8),
        Skill(name: 'Git', level: 0.7),
        Skill(name: 'JavaScript', level: 0.6),
        Skill(name: 'React', level: 0.5),
      ],
      education: [
        Education(
          institution: 'University of Technology',
          degree: 'Master of Computer Science',
          duration: '2015 - 2017',
          achievements: ['GPA: 3.8/4.0', 'Mobile Computing Specialization'],
        ),
        Education(
          institution: 'State University',
          degree: 'Bachelor of Software Engineering',
          duration: '2011 - 2015',
          achievements: [
            'GPA: 3.6/4.0',
            'Dean\'s List',
            'Software Development Club President',
          ],
        ),
      ],
      contact: Contact(
        email: 'jane.doe@example.com',
        phone: '+1 (123) 456-7890',
        location: 'San Francisco, CA',
        socialLinks: {
          'LinkedIn': 'https://linkedin.com/in/janedoe',
          'GitHub': 'https://github.com/janedoe',
          'Twitter': 'https://twitter.com/janedoe',
        },
      ),
    );
  }
}

class Experience {
  final String company;
  final String role;
  final String duration;
  final String description;
  final List<String> achievements;

  Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.description,
    required this.achievements,
  });
}

class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String linkUrl;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.linkUrl,
  });
}

class Skill {
  final String name;
  final double level; // 0.0 to 1.0

  Skill({required this.name, required this.level});
}

class Education {
  final String institution;
  final String degree;
  final String duration;
  final List<String> achievements;

  Education({
    required this.institution,
    required this.degree,
    required this.duration,
    required this.achievements,
  });
}

class Contact {
  final String email;
  final String phone;
  final String location;
  final Map<String, String> socialLinks;

  Contact({
    required this.email,
    required this.phone,
    required this.location,
    required this.socialLinks,
  });
}
