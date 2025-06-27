import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'folder_drop_down_global_model.dart';
export 'folder_drop_down_global_model.dart';

class FolderDropDownGlobalWidget extends StatefulWidget {
  const FolderDropDownGlobalWidget({
    super.key,
    required this.folderRef,
  });

  final StudyMaterialsRecord? folderRef;

  @override
  State<FolderDropDownGlobalWidget> createState() =>
      _FolderDropDownGlobalWidgetState();
}

class _FolderDropDownGlobalWidgetState
    extends State<FolderDropDownGlobalWidget> {
  late FolderDropDownGlobalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FolderDropDownGlobalModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder<List<UserFilesMetadataRecord>>(
        future: queryUserFilesMetadataRecordOnce(
          parent: widget.folderRef?.reference,
          queryBuilder: (userFilesMetadataRecord) =>
              userFilesMetadataRecord.where(
            'userID',
            isEqualTo: currentUserUid,
          ),
          singleRecord: true,
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 25.0,
                height: 25.0,
                child: SpinKitFadingCube(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 25.0,
                ),
              ),
            );
          }
          List<UserFilesMetadataRecord>
              dropdown1OptionsUserFilesMetadataRecordList = snapshot.data!;
          final dropdown1OptionsUserFilesMetadataRecord =
              dropdown1OptionsUserFilesMetadataRecordList.isNotEmpty
                  ? dropdown1OptionsUserFilesMetadataRecordList.first
                  : null;

          return Container(
            width: 200.0,
            height: 90.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4.0,
                  color: Color(0x33000000),
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Options',
                        textAlign: TextAlign.start,
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                      ),
                      Icon(
                        FFIcons.kdragHorizontal,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'FOLDER_DROP_DOWN_GLOBAL_replaceWidget_ON');
                      if (dropdown1OptionsUserFilesMetadataRecord.isFavorite) {
                        logFirebaseEvent('replaceWidget_backend_call');

                        await dropdown1OptionsUserFilesMetadataRecord.reference
                            .update(createUserFilesMetadataRecordData(
                          isFavorite: !dropdown1OptionsUserFilesMetadataRecord
                              .isFavorite,
                        ));
                      } else {
                        logFirebaseEvent('replaceWidget_backend_call');

                        await UserFilesMetadataRecord.createDoc(
                                widget.folderRef!.reference)
                            .set(createUserFilesMetadataRecordData(
                          userID: currentUserUid,
                          lastOpenedAt: getCurrentTimestamp,
                          openCount: 1,
                          isFavorite: true,
                        ));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (!dropdown1OptionsUserFilesMetadataRecord!
                                .isFavorite)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  FFIcons.kstar,
                                  color: FlutterFlowTheme.of(context).warning,
                                  size: 20.0,
                                ),
                              ),
                            if (dropdown1OptionsUserFilesMetadataRecord
                                    .isFavorite ??
                                true)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  FFIcons.kstar,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                              ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  dropdown1OptionsUserFilesMetadataRecord
                                          .isFavorite
                                      ? 'Unmark As Favorite'
                                      : 'Mark As Favorite',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelLargeFamily,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelLargeIsCustom,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
