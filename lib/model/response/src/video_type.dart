import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/widgets/stateable_outlined_button.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_type.freezed.dart';
part 'video_type.g.dart';

@freezed
abstract class VideoType with _$VideoType {
  const factory VideoType({
    @Default([]) List<VideoTypeList>? t1,
    @Default([]) List<VideoTypeList>? t2,
    @Default([]) List<VideoTypeList>? t3,
    @Default([]) List<VideoTypeList>? t4,
    @Default([]) List<VideoTypeList>? t5,
  }) = _VideoType;

  factory VideoType.fromJson(Map<String, Object?> json) =>
      _$VideoTypeFromJson(json);
}

class VideoTypeContainer extends StatefulWidget {
  final VideoType? videoType;
  const VideoTypeContainer({super.key, this.videoType});

  @override
  State<VideoTypeContainer> createState() => _VideoTypeContainerState();
}

class _VideoTypeContainerState extends State<VideoTypeContainer> {
  VideoTypeList? t1, t2, t3, t4, t5;
  Widget buildSections() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.videoType?.t1?.isNotEmpty ?? false)
          _buildSection(
            title: t.video_type.t1,
            items: widget.videoType?.t1 ?? [],
            selectedItem: t1,
            callback: (e) => setState(() {
              t1 = e;
            }),
          ),

        if (widget.videoType?.t2?.isNotEmpty ?? false)
          _buildSection(
            title: t.video_type.t2,
            items: widget.videoType?.t2 ?? [],
            selectedItem: t2,
            callback: (e) => setState(() {
              t2 = e;
            }),
          ),

        if (widget.videoType?.t3?.isNotEmpty ?? false)
          _buildSection(
            title: t.video_type.t3,
            items: widget.videoType?.t3 ?? [],
            selectedItem: t3,
            callback: (e) => setState(() {
              t3 = e;
            }),
          ),

        if (widget.videoType?.t4?.isNotEmpty ?? false)
          _buildSection(
            title: t.video_type.t4,
            items: widget.videoType?.t4 ?? [],
            selectedItem: t4,
            callback: (e) => setState(() {
              t4 = e;
            }),
          ),

        if (widget.videoType?.t5?.isNotEmpty ?? false)
          _buildSection(
            title: t.video_type.t5,
            items: widget.videoType?.t5 ?? [],
            selectedItem: t5,
            callback: (e) => setState(() {
              t5 = e;
            }),
          ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<VideoTypeList> items,
    VideoTypeList? selectedItem,
    Function(VideoTypeList)? callback,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            ...items.map((e) {
              return StateableOutlinedButton(
                item: e,
                isHightlight: selectedItem?.idcode == e.idcode,
                callback: (item) {
                  if (callback != null) {
                    callback(item);
                  }
                },
              );
            }),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSections();
  }
}
