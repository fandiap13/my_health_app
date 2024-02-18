import 'package:ble_client/screen/riwayat_kesehatan/components/toggle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ChartOptionsWidget extends StatefulWidget {
  const ChartOptionsWidget({
    required this.onRefresh,
    required this.toggleItems,
    required this.onAddItems,
    required this.onRemoveItems,
    Key? key,
  }) : super(key: key);

  final VoidCallback onRefresh;
  final VoidCallback onAddItems;
  final VoidCallback onRemoveItems;
  final List<Widget> toggleItems;

  @override
  _ChartOptionsWidgetState createState() => _ChartOptionsWidgetState();
}

class _ChartOptionsWidgetState extends State<ChartOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: ListTile(
                  trailing: const Icon(Icons.add),
                  title: const Text('Add data'),
                  onTap: widget.onAddItems,
                ),
              ),
              Flexible(
                child: ListTile(
                  trailing: const Icon(Icons.remove),
                  title: const Text('Remove data'),
                  onTap: widget.onRemoveItems,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: ToggleItem(
                  value: timeDilation == 10,
                  title: 'Slow animations',
                  onChanged: (value) {
                    setState(() {
                      timeDilation = timeDilation == 10 ? 1 : 10;
                    });
                  },
                ),
              ),
              Flexible(
                child: ListTile(
                  enabled: widget.onRefresh != null,
                  trailing: const Icon(Icons.refresh),
                  title: const Text('Refresh dataset'),
                  onTap: widget.onRefresh,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Text(
                'OPTIONS',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
          ),
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: widget.toggleItems,
            ),
          ),
        ],
      ),
    );
  }
}
