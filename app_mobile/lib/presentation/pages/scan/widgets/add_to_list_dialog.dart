import 'package:app_mobile/provider/scan_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToListDialog extends StatefulWidget {
  const AddToListDialog({super.key});

  @override
  State<AddToListDialog> createState() => _AddToListDialogState();
}

class _AddToListDialogState extends State<AddToListDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScanProvider>();

    return DraggableScrollableSheet(
      initialChildSize: 0.62,
      minChildSize: 0.45,
      maxChildSize: 0.86,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 42,
                height: 4.5,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Add to list',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: provider.lists.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final item = provider.lists[i];
                    final selected = provider.selectedListId == item.id;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.name),
                      trailing: selected
                          ? const Icon(Icons.check_circle_rounded, color: Color(0xFF2D6BFF))
                          : const Icon(Icons.circle_outlined, color: Color(0xFFB8B8B8)),
                      onTap: () => provider.selectList(item.id),
                    );
                  },
                ),
              ),

              // Create new list + Add list
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Create a new list',
                          filled: true,
                          fillColor: const Color(0xFFF2F4F6),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: provider.isBusy
                          ? null
                          : () {
                              provider.createNewList(_controller.text);
                              _controller.clear();
                            },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2D6BFF)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      child: const Text('Add list'),
                    ),
                  ],
                ),
              ),

              // Save button
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: provider.isBusy || provider.selectedListId == null
                        ? null
                        : () async {
                            await provider.saveToSelectedList();
                            if (context.mounted) Navigator.of(context).pop();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D6BFF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: provider.isBusy
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}