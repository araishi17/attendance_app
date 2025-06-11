import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/report.dart';

class PdfService {
  Future<pw.Document> generateReportPdf(Report report) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Laporan Harian', style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 20),
            pw.Text('Tugas: ${report.task}'),
            pw.Text('Durasi: ${report.duration} menit'),
            pw.Text('Catatan: ${report.notes}'),
            pw.Text('Tanggal: ${report.date.toString()}'),
          ],
        ),
      ),
    );
    return pdf;
  }
}
