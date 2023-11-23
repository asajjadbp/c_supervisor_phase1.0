import 'package:c_supervisor/ui/pages/knowledge_share/uploaded_files/uploaded_files_content.dart';
import 'package:flutter/material.dart';



class UploadedFilesPage extends StatelessWidget {
  const UploadedFilesPage({Key? key, required this.moduleName}) : super(key: key);
  final String moduleName;

  @override
  Widget build(BuildContext context) {
    /// TODO:wrap this with BlocProvider
    return UploadedFilesContent(
      moduleName: moduleName,
    );
  }
}
