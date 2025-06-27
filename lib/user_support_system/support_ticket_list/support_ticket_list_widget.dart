import '/backend/backend.dart';
import '/empty_list_comp/empty_state_dynamic/empty_state_dynamic_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'support_ticket_list_model.dart';
export 'support_ticket_list_model.dart';

class SupportTicketListWidget extends StatefulWidget {
  const SupportTicketListWidget({super.key});

  static String routeName = 'support_TicketList';
  static String routePath = 'supportTicketList';

  @override
  State<SupportTicketListWidget> createState() =>
      _SupportTicketListWidgetState();
}

class _SupportTicketListWidgetState extends State<SupportTicketListWidget> {
  late SupportTicketListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupportTicketListModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'support_TicketList'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'support_TicketList',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              title: Text(
                'Support Tickets',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                    ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 16.0, 8.0),
                  child: FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).primary,
                    borderRadius: 12.0,
                    borderWidth: 2.0,
                    buttonSize: 40.0,
                    fillColor: FlutterFlowTheme.of(context).accent1,
                    icon: Icon(
                      Icons.post_add_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      logFirebaseEvent(
                          'SUPPORT_TICKET_LIST_post_add_rounded_ICN');
                      logFirebaseEvent('IconButton_navigate_to');

                      context.pushNamed(SupportSubmitTicketWidget.routeName);
                    },
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Below are a list of recent tickets created',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelMediumIsCustom,
                          ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<List<SupportTicketsRecord>>(
                      stream: querySupportTicketsRecord(
                        queryBuilder: (supportTicketsRecord) =>
                            supportTicketsRecord.orderBy('createdTime'),
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
                        List<SupportTicketsRecord>
                            listViewSupportTicketsRecordList = snapshot.data!;
                        if (listViewSupportTicketsRecordList.isEmpty) {
                          return Center(
                            child: Container(
                              height: 330.0,
                              child: EmptyStateDynamicWidget(
                                icon: Icon(
                                  Icons.live_help_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 90.0,
                                ),
                                title: 'No Support Tickets Exist',
                                body:
                                    'Ah, you are in luck, none of your support tickets exist.',
                                buttonText: 'Create Ticket',
                                buttonAction: () async {
                                  logFirebaseEvent(
                                      'SUPPORT_TICKET_LIST_ListView_otsjm33l_CA');
                                  logFirebaseEvent('ListView_navigate_to');

                                  context.pushNamed(
                                      SupportSubmitTicketWidget.routeName);
                                },
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            12.0,
                            0,
                            44.0,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: listViewSupportTicketsRecordList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12.0),
                          itemBuilder: (context, listViewIndex) {
                            final listViewSupportTicketsRecord =
                                listViewSupportTicketsRecordList[listViewIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'SUPPORT_TICKET_LIST_listContainer_ON_TAP');
                                  logFirebaseEvent('listContainer_navigate_to');

                                  context.pushNamed(
                                    SupportTicketDetailsWidget.routeName,
                                    queryParameters: {
                                      'ticketRef': serializeParam(
                                        listViewSupportTicketsRecord,
                                        ParamType.Document,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'ticketRef': listViewSupportTicketsRecord,
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  constraints: BoxConstraints(
                                    maxWidth: 570.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listViewSupportTicketsRecord.name,
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmallFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmallIsCustom,
                                              ),
                                        ),
                                        AutoSizeText(
                                          listViewSupportTicketsRecord
                                              .description
                                              .maybeHandleOverflow(
                                            maxChars: 140,
                                          ),
                                          maxLines: 3,
                                          minFontSize: 12.0,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelMediumIsCustom,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 4.0, 0.0, 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 12.0,
                                                height: 12.0,
                                                decoration: BoxDecoration(
                                                  color: () {
                                                    if (listViewSupportTicketsRecord
                                                            .priorityLevel ==
                                                        'High') {
                                                      return Color(0x4CFF5963);
                                                    } else if (listViewSupportTicketsRecord
                                                            .priorityLevel ==
                                                        'Medium') {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .accent3;
                                                    } else if (listViewSupportTicketsRecord
                                                            .priorityLevel ==
                                                        'Emergency') {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .error;
                                                    } else {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .accent2;
                                                    }
                                                  }(),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: () {
                                                      if (listViewSupportTicketsRecord
                                                              .priorityLevel ==
                                                          'High') {
                                                        return FlutterFlowTheme
                                                                .of(context)
                                                            .error;
                                                      } else if (listViewSupportTicketsRecord
                                                              .priorityLevel ==
                                                          'Medium') {
                                                        return FlutterFlowTheme
                                                                .of(context)
                                                            .tertiary;
                                                      } else if (listViewSupportTicketsRecord
                                                              .priorityLevel ==
                                                          'Emergency') {
                                                        return FlutterFlowTheme
                                                                .of(context)
                                                            .error;
                                                      } else {
                                                        return FlutterFlowTheme
                                                                .of(context)
                                                            .secondary;
                                                      }
                                                    }(),
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    child: Text(
                                                      listViewSupportTicketsRecord
                                                          .priorityLevel,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (listViewSupportTicketsRecord
                                                          .image !=
                                                      '')
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 12.0, 0.0),
                                                  child: Icon(
                                                    Icons.attach_file_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              Container(
                                                height: 32.0,
                                                decoration: BoxDecoration(
                                                  color: () {
                                                    if (listViewSupportTicketsRecord
                                                            .status ==
                                                        'Submitted') {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .accent3;
                                                    } else if (listViewSupportTicketsRecord
                                                            .status ==
                                                        'In Progress') {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .accent1;
                                                    } else if (listViewSupportTicketsRecord
                                                            .status ==
                                                        'Complete') {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .accent2;
                                                    } else {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground;
                                                    }
                                                  }(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  border: Border.all(
                                                    color: () {
                                                      if (listViewSupportTicketsRecord
                                                              .status ==
                                                          'Submitted') {
                                                        return FlutterFlowTheme
                                                                .of(context)
                                                            .tertiary;
                                                      } else if (listViewSupportTicketsRecord
                                                              .status ==
                                                          'In Progress') {
                                                        return FlutterFlowTheme
                                                                .of(context)
                                                            .primary;
                                                      } else if (listViewSupportTicketsRecord
                                                              .status ==
                                                          'Complete') {
                                                        return FlutterFlowTheme
                                                                .of(context)
                                                            .secondary;
                                                      } else {
                                                        return FlutterFlowTheme
                                                                .of(context)
                                                            .error;
                                                      }
                                                    }(),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    child: Text(
                                                      listViewSupportTicketsRecord
                                                          .status,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: () {
                                                              if (listViewSupportTicketsRecord
                                                                      .status ==
                                                                  'Submitted') {
                                                                return FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary;
                                                              } else if (listViewSupportTicketsRecord
                                                                      .status ==
                                                                  'In Progress') {
                                                                return FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary;
                                                              } else if (listViewSupportTicketsRecord
                                                                      .status ==
                                                                  'Complete') {
                                                                return FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary;
                                                              } else {
                                                                return FlutterFlowTheme.of(
                                                                        context)
                                                                    .error;
                                                              }
                                                            }(),
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 4.0, 4.0, 4.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: RichText(
                                                    textScaler:
                                                        MediaQuery.of(context)
                                                            .textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Ticket #: ',
                                                          style: TextStyle(),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              listViewSupportTicketsRecord
                                                                  .ticketID
                                                                  .toString(),
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  dateTimeFormat(
                                                    "relative",
                                                    listViewSupportTicketsRecord
                                                        .createdTime!,
                                                    locale: FFLocalizations.of(
                                                                context)
                                                            .languageShortCode ??
                                                        FFLocalizations.of(
                                                                context)
                                                            .languageCode,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmallFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmallIsCustom,
                                                          ),
                                                ),
                                                StreamBuilder<UsersRecord>(
                                                  stream: UsersRecord.getDocument(
                                                      listViewSupportTicketsRecord
                                                          .createdBy!),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 25.0,
                                                          height: 25.0,
                                                          child:
                                                              SpinKitFadingCube(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 25.0,
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    final containerUsersRecord =
                                                        snapshot.data!;

                                                    return Container(
                                                      width: 32.0,
                                                      height: 32.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(2.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                          child:
                                                              CachedNetworkImage(
                                                            fadeInDuration:
                                                                Duration(
                                                                    milliseconds:
                                                                        200),
                                                            fadeOutDuration:
                                                                Duration(
                                                                    milliseconds:
                                                                        200),
                                                            imageUrl: containerUsersRecord
                                                                            .photoUrl !=
                                                                        ''
                                                                ? containerUsersRecord
                                                                    .photoUrl
                                                                : random_data
                                                                    .randomImageUrl(
                                                                    0,
                                                                    0,
                                                                  ),
                                                            width: 300.0,
                                                            height: 200.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ].divide(SizedBox(width: 8.0)),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8.0)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
