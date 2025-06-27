import '/backend/backend.dart';
import '/components/folder_drop_down_personal_vault_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'folder_block_user_vault_model.dart';
export 'folder_block_user_vault_model.dart';

class FolderBlockUserVaultWidget extends StatefulWidget {
  const FolderBlockUserVaultWidget({
    super.key,
    required this.userFolderRecord,
    required this.onTap,
  });

  final UserPersonalVaultRecord? userFolderRecord;
  final Future Function(String pathPath)? onTap;

  @override
  State<FolderBlockUserVaultWidget> createState() =>
      _FolderBlockUserVaultWidgetState();
}

class _FolderBlockUserVaultWidgetState
    extends State<FolderBlockUserVaultWidget> {
  late FolderBlockUserVaultModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FolderBlockUserVaultModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('FOLDER_BLOCK_USER_VAULT_Container_756i1l');
        logFirebaseEvent('Container_execute_callback');
        await widget.onTap?.call(
          '${widget.userFolderRecord?.parentPath}${widget.userFolderRecord?.name}/',
        );
      },
      child: Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            FFAppConstants.colours.elementAtOrNull(
                functions.randomNumberGenerator(
                    0, 9, widget.userFolderRecord!.reference.id)),
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
              Align(
                alignment: AlignmentDirectional(1.0, -1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 4.0, 8.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (valueOrDefault<bool>(
                        widget.userFolderRecord?.isFavorite,
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
                                'FOLDER_BLOCK_USER_VAULT_Icon_mw7edy52_ON');
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
                                  child: FolderDropDownPersonalVaultWidget(
                                    folderRecord: widget.userFolderRecord!,
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      valueOrDefault<String>(
                        widget.userFolderRecord?.name,
                        '{FolderName}',
                      ),
                      minFontSize: 10.0,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                    AutoSizeText(
                      valueOrDefault<String>(
                        dateTimeFormat(
                          "relative",
                          widget.userFolderRecord?.lastOpened,
                          locale: FFLocalizations.of(context).languageCode,
                        ),
                        'never opened',
                      ),
                      minFontSize: 10.0,
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelSmallFamily,
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
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
  }
}
