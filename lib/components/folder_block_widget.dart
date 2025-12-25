import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/folder_drop_down_global_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'folder_block_model.dart';
export 'folder_block_model.dart';

class FolderBlockWidget extends StatefulWidget {
  const FolderBlockWidget({
    super.key,
    required this.folderRef,
    required this.onTap,
  });

  final StudyMaterialsRecord? folderRef;
  final Future Function(String parentPath)? onTap;

  @override
  State<FolderBlockWidget> createState() => _FolderBlockWidgetState();
}

class _FolderBlockWidgetState extends State<FolderBlockWidget> {
  late FolderBlockModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FolderBlockModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: StreamBuilder<List<UserFilesMetadataRecord>>(
        stream: queryUserFilesMetadataRecord(
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
          List<UserFilesMetadataRecord> containerUserFilesMetadataRecordList =
              snapshot.data!;
          final containerUserFilesMetadataRecord =
              containerUserFilesMetadataRecordList.isNotEmpty
                  ? containerUserFilesMetadataRecordList.first
                  : null;

          return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('FOLDER_BLOCK_Container_jwvqr8s5_ON_TAP');
              if (containerUserFilesMetadataRecord != null) {
                logFirebaseEvent('Container_backend_call');

                await containerUserFilesMetadataRecord.reference.update({
                  ...createUserFilesMetadataRecordData(
                    lastOpenedAt: getCurrentTimestamp,
                  ),
                  ...mapToFirestore(
                    {
                      'open_count': FieldValue.increment(1),
                    },
                  ),
                });
              } else {
                logFirebaseEvent('Container_backend_call');

                await UserFilesMetadataRecord.createDoc(
                        widget.folderRef!.reference)
                    .set(createUserFilesMetadataRecordData(
                  userID: currentUserUid,
                  lastOpenedAt: getCurrentTimestamp,
                  openCount: 1,
                ));
              }

              logFirebaseEvent('Container_execute_callback');
              await widget.onTap?.call(
                valueOrDefault<String>(
                  widget.folderRef?.nestedPath,
                  'home/',
                ),
              );
            },
            child: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  FFAppConstants.colours.elementAtOrNull(
                      functions.randomNumberGenerator(
                          0, 9, widget.folderRef!.reference.id)),
                  FlutterFlowTheme.of(context).velvetSky,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 4.0, 8.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (valueOrDefault<bool>(
                            valueOrDefault<bool>(
                                  containerUserFilesMetadataRecord?.isFavorite,
                                  false,
                                ) &&
                                (containerUserFilesMetadataRecord != null),
                            false,
                          ))
                            Icon(
                              FFIcons.kstar,
                              color: FlutterFlowTheme.of(context).warning,
                              size: 24.0,
                            ),
                          Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'FOLDER_BLOCK_COMP_Icon_wh71eidm_ON_TAP');
                                logFirebaseEvent('Icon_alert_dialog');
                                await showAlignedDialog(
                                  context: context,
                                  isGlobal: false,
                                  avoidOverflow: true,
                                  targetAnchor: AlignmentDirectional(-1.0, 1.0)
                                      .resolve(Directionality.of(context)),
                                  followerAnchor: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: FolderDropDownGlobalWidget(
                                        folderRef: widget.folderRef!,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                FFIcons.kdotsThreeOutlineVerticalBold,
                                color: FlutterFlowTheme.of(context).info,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            valueOrDefault<String>(
                              widget.folderRef?.fileName,
                              'TextBooks',
                            ),
                            minFontSize: 10.0,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).info,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          if (containerUserFilesMetadataRecord != null)
                            AutoSizeText(
                              valueOrDefault<String>(
                                dateTimeFormat(
                                  "relative",
                                  containerUserFilesMetadataRecord
                                      .lastOpenedAt,
                                  locale: FFLocalizations.of(context)
                                          .languageShortCode ??
                                      FFLocalizations.of(context).languageCode,
                                ),
                                '5 mins ago',
                              ),
                              minFontSize: 10.0,
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelSmallFamily,
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 8.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelSmallIsCustom,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
