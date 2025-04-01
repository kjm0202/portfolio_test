import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:portfolio/portfolio_data.dart';

class PdfGenerator {
  static Future<Uint8List> generateResume(ProfileData profileData) async {
    final pdf = pw.Document();
    final regularFont = pw.Font.helvetica();
    final boldFont = pw.Font.helveticaBold();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (pw.Context context) => _buildHeader(profileData, boldFont),
        build:
            (pw.Context context) => [
              _buildPersonalInfo(profileData, regularFont, boldFont),
              pw.SizedBox(height: 20),
              _buildSummary(profileData, regularFont, boldFont),
              pw.SizedBox(height: 20),
              _buildExperience(profileData, regularFont, boldFont),
              pw.SizedBox(height: 20),
              _buildSkills(profileData, regularFont, boldFont),
              pw.SizedBox(height: 20),
              _buildEducation(profileData, regularFont, boldFont),
              pw.SizedBox(height: 20),
              _buildProjects(profileData, regularFont, boldFont),
              pw.SizedBox(height: 20),
              _buildContact(profileData, regularFont, boldFont),
            ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(ProfileData profileData, pw.Font boldFont) {
    return pw.Header(
      level: 0,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            profileData.name,
            style: pw.TextStyle(font: boldFont, fontSize: 24),
          ),
          pw.Text(
            'Curriculum Vitae',
            style: pw.TextStyle(font: boldFont, fontSize: 18),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPersonalInfo(
    ProfileData profileData,
    pw.Font regularFont,
    pw.Font boldFont,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          profileData.tagline,
          style: pw.TextStyle(font: boldFont, fontSize: 16),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          profileData.contact.email,
          style: pw.TextStyle(font: regularFont, fontSize: 12),
        ),
        pw.Text(
          profileData.contact.phone,
          style: pw.TextStyle(font: regularFont, fontSize: 12),
        ),
        pw.Text(
          profileData.contact.location,
          style: pw.TextStyle(font: regularFont, fontSize: 12),
        ),
      ],
    );
  }

  static pw.Widget _buildSummary(
    ProfileData profileData,
    pw.Font regularFont,
    pw.Font boldFont,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('SUMMARY', style: pw.TextStyle(font: boldFont, fontSize: 14)),
        pw.Divider(),
        pw.Text(
          profileData.bio,
          style: pw.TextStyle(font: regularFont, fontSize: 12),
        ),
      ],
    );
  }

  static pw.Widget _buildExperience(
    ProfileData profileData,
    pw.Font regularFont,
    pw.Font boldFont,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'PROFESSIONAL EXPERIENCE',
          style: pw.TextStyle(font: boldFont, fontSize: 14),
        ),
        pw.Divider(),
        ...profileData.experiences.map(
          (experience) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 12),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      experience.role,
                      style: pw.TextStyle(font: boldFont, fontSize: 12),
                    ),
                    pw.Text(
                      experience.duration,
                      style: pw.TextStyle(font: regularFont, fontSize: 12),
                    ),
                  ],
                ),
                pw.Text(
                  experience.company,
                  style: pw.TextStyle(
                    font: regularFont,
                    fontSize: 12,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  experience.description,
                  style: pw.TextStyle(font: regularFont, fontSize: 10),
                ),
                pw.SizedBox(height: 4),
                ...experience.achievements.map(
                  (achievement) => pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 2),
                    child: pw.Text(
                      '• $achievement',
                      style: pw.TextStyle(font: regularFont, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildSkills(
    ProfileData profileData,
    pw.Font regularFont,
    pw.Font boldFont,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('SKILLS', style: pw.TextStyle(font: boldFont, fontSize: 14)),
        pw.Divider(),
        pw.Wrap(
          spacing: 8,
          runSpacing: 4,
          children:
              profileData.skills
                  .map(
                    (skill) => pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.grey),
                        borderRadius: pw.BorderRadius.circular(4),
                      ),
                      child: pw.Text(
                        skill.name,
                        style: pw.TextStyle(font: regularFont, fontSize: 10),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  static pw.Widget _buildEducation(
    ProfileData profileData,
    pw.Font regularFont,
    pw.Font boldFont,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('EDUCATION', style: pw.TextStyle(font: boldFont, fontSize: 14)),
        pw.Divider(),
        ...profileData.education.map(
          (education) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      education.degree,
                      style: pw.TextStyle(font: boldFont, fontSize: 12),
                    ),
                    pw.Text(
                      education.duration,
                      style: pw.TextStyle(font: regularFont, fontSize: 12),
                    ),
                  ],
                ),
                pw.Text(
                  education.institution,
                  style: pw.TextStyle(
                    font: regularFont,
                    fontSize: 12,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
                pw.SizedBox(height: 4),
                ...education.achievements.map(
                  (achievement) => pw.Text(
                    '• $achievement',
                    style: pw.TextStyle(font: regularFont, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildProjects(
    ProfileData profileData,
    pw.Font regularFont,
    pw.Font boldFont,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('PROJECTS', style: pw.TextStyle(font: boldFont, fontSize: 14)),
        pw.Divider(),
        ...profileData.projects.map(
          (project) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  project.title,
                  style: pw.TextStyle(font: boldFont, fontSize: 12),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  project.description,
                  style: pw.TextStyle(font: regularFont, fontSize: 10),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'Technologies: ${project.technologies.join(', ')}',
                  style: pw.TextStyle(
                    font: regularFont,
                    fontSize: 10,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildContact(
    ProfileData profileData,
    pw.Font regularFont,
    pw.Font boldFont,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'SOCIAL LINKS',
          style: pw.TextStyle(font: boldFont, fontSize: 14),
        ),
        pw.Divider(),
        ...profileData.contact.socialLinks.entries.map(
          (entry) => pw.Text(
            '${entry.key}: ${entry.value}',
            style: pw.TextStyle(font: regularFont, fontSize: 10),
          ),
        ),
      ],
    );
  }
}
