import 'package:flutter/material.dart';
import 'package:stories/bloc/block_provider.dart';
import 'package:stories/bloc/stories_bloc.dart';
import 'package:stories/models.dart';
import 'package:stories/utils/api.dart';

class StoriesArchiveTray extends StatelessWidget {
  List<Tray> trays;

  StoriesArchiveTray(this.trays);

  @override
  Widget build(BuildContext context) {
    final storiesBloc = BlocProvider.of<StoriesBloc>(context);

    return StreamBuilder<String>(
        initialData: "__TODAY__",
        stream: storiesBloc.selectedTray,
        builder: (context, snapshot) {
          return Container(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                separatorBuilder: (context, index) => Divider(
                      indent: 12,
                      color: Colors.black,
                    ),
                itemCount: this.trays.length,
                itemBuilder: (BuildContext context, int index) {
                  return new TrayItem(index, this.trays[index], snapshot.data, storiesBloc);
                }),
          );
        });
  }
}

class TrayItem extends StatefulWidget {
  int index;
  Tray tray;
  String selectedId;
  StoriesBloc bloc;

  TrayItem(this.index, this.tray, this.selectedId, this.bloc);

  @override
  _TrayItemState createState() => _TrayItemState();
}

class _TrayItemState extends State<TrayItem> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        select(context);
      },
      child: Column(children: <Widget>[
        Container(
          width: 64,
          height: 64,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
              border: Border.all(
                  color: widget.tray.id == widget.selectedId ? Colors.greenAccent[100] : Colors.grey[100],
                  width: widget.tray.id == widget.selectedId ? 4 : 0),
              image: DecorationImage(image: NetworkImage(widget.tray.coverMedia.croppedImageVersion.url)),
              shape: BoxShape.circle),
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent[100]),
                )
              : Container(),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: Text(widget.tray.title),
        ),
      ]),
    );
  }

  void select(BuildContext context) async {
    final storiesBloc = BlocProvider.of<StoriesBloc>(context);

    if (widget.tray.id == "_TODAY_") {
      storiesBloc.addStories(storiesBloc.todaysStories);
      storiesBloc.selectTray(widget.tray.id);
      return;
    }
    setState(() {
      loading = true;
    });
    var highlight = await Api.getSingleHighLights(widget.tray.id);
    storiesBloc.addStories(highlight.highLight.items);
    storiesBloc.selectTray(widget.tray.id);
    setState(() {
      loading = false;
    });
  }
}
