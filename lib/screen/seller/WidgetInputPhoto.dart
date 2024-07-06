import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoStack extends StatefulWidget {
  const PhotoStack({super.key});

  @override
  _PhotoStackState createState() => _PhotoStackState();
}

class _PhotoStackState extends State<PhotoStack> {
  File? _selectedSelfieFile;
  File? _selectedKtpFile;

  Future<void> _openSelfiePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        setState(() {
          _selectedSelfieFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print('Error picking selfie file: $e');
      // Handle error as needed
    }
  }

  Future<void> _openKtpPicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        setState(() {
          _selectedKtpFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print('Error picking KTP file: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedSelfieFile != null
                    ? Image.file(
                        _selectedSelfieFile!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Text('Belum ada foto selfie dipilih',
                            style: GoogleFonts.patrickHand()),
                      ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _openSelfiePicker,
                  tooltip: 'Pilih Foto Selfie',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedKtpFile != null
                    ? Image.file(
                        _selectedKtpFile!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Text('Belum ada foto KTP dipilih',
                            style: GoogleFonts.patrickHand()),
                      ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _openKtpPicker,
                  tooltip: 'Pilih Foto KTP',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
