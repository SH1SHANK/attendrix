import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_tags_personal_vault_model.dart';
export 'add_tags_personal_vault_model.dart';

/// Design a FlutterFlow Bottom Sheet component named AddTagsToFileSheet with
/// the following behavior and design specifications:
///
/// 🧩 Functionality
/// Input Sources:
///
/// A searchable dropdown or chip selector that displays existing user-defined
/// tags.
///
/// A TextField that allows the user to input new tags (which are not part of
/// the existing list).
///
/// Add Button:
///
/// A button (icon or text-based) to submit the selected or typed tag.
///
/// On clicking, the tag is:
///
/// Added to the list of tags to be attached to the file.
///
/// The input field is cleared and refocused to allow seamless new tag
/// addition.
///
/// Tag Display Area:
///
/// A scrollable horizontal container that displays the current list of
/// selected tags.
///
/// Each tag should appear as a removable chip (with an X or trash icon).
///
/// Final Submission:
///
/// A prominent “Attach Tags” button at the bottom that triggers a callback or
/// action (e.g., API call, state update).
///
/// 🎨 Design Specifications (Blue-Themed, Professional, Elegant)
/// 📱 Component Type:
/// Bottom Sheet (Modal, scrollable)
///
/// 🖼️ Background:
/// Gradient or flat light-blue tone (#E6F0FA to #F8FBFF)
///
/// Rounded top corners (radius: 28)
///
/// Soft drop shadow (blur: 20, opacity: 0.1)
///
/// 🔤 Typography:
/// Headline: Add Tags to File
///
/// Font: Inter or Poppins, Weight: 600, Size: 20, Color: #1A237E
///
/// Subtext/Instruction: Select from existing or add new tags below.
///
/// Font: Inter, Weight: 400, Size: 14, Color: #5C6BC0
///
/// 🔍 Existing Tags Dropdown/Selector:
/// Use ChoiceChips or searchable dropdown.
///
/// Appearance:
///
/// Chip Background: #E3F2FD
///
/// Selected Chip: #BBDEFB, Text: #0D47A1
///
/// TextStyle: 14pt, medium weight
///
/// Padding: 8, Radius: 12
///
/// 📝 New Tag Input Field:
/// Label: Add a new tag
///
/// Border: Rounded (radius: 12), Blue border when focused
///
/// Background: White (#FFFFFF)
///
/// Shadow: Subtle (blur: 6, opacity: 0.06)
///
/// Icon/Button: ➕ Add Icon on the right, Blue
///
/// 🧱 Tag Display Container:
/// Title: Tags to Attach
///
/// Horizontal Wrap or Row with scroll
///
/// Tag Chips:
///
/// Blue background (#D6E4FF)
///
/// Text: #1A237E
///
/// Close icon on right (X, size: 14)
///
/// Padding inside chip: 8 horizontal, 4 vertical
///
/// Margin: 6px between chips
///
/// ✅ Submit Button:
/// Label: Attach Tags
///
/// Full-width button
///
/// Rounded (radius: 14)
///
/// Gradient: #1E88E5 → #1976D2
///
/// Text: White, Bold (16pt)
///
/// Shadow: Medium blue shadow
///
/// ⚙️ Functional Behavior
/// Tags are stored in a local List<String> variable (e.g., selectedTags).
///
/// When the user submits a tag:
///
/// Check if it's already added (avoid duplicates).
///
/// Add to the list and update the UI.
///
/// Clear and refocus the input.
///
/// Allow removing tags from the list via chip tap.
class AddTagsPersonalVaultWidget extends StatefulWidget {
  const AddTagsPersonalVaultWidget({
    super.key,
    required this.fileRef,
  });

  final UserPersonalVaultRecord? fileRef;

  @override
  State<AddTagsPersonalVaultWidget> createState() =>
      _AddTagsPersonalVaultWidgetState();
}

class _AddTagsPersonalVaultWidgetState
    extends State<AddTagsPersonalVaultWidget> {
  late AddTagsPersonalVaultModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddTagsPersonalVaultModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ADD_TAGS_PERSONAL_VAULT_addTagsPersonalV');
      logFirebaseEvent('addTagsPersonalVault_update_component_st');
      _model.addedTags = widget.fileRef!.tags.toList().cast<String>();
      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Align(
        alignment: AlignmentDirectional(0.0, 1.0),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
          child: FutureBuilder<List<UserPersonalVaultRecord>>(
            future: queryUserPersonalVaultRecordOnce(
              parent: currentUserReference,
              queryBuilder: (userPersonalVaultRecord) =>
                  userPersonalVaultRecord.where(
                'hasTags',
                isEqualTo: true,
              ),
              limit: 12,
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
              List<UserPersonalVaultRecord>
                  containerUserPersonalVaultRecordList = snapshot.data!;

              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Color(0x1A000000),
                      offset: Offset(
                        0.0,
                        -4.0,
                      ),
                      spreadRadius: 0.0,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(28.0),
                    topRight: Radius.circular(28.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          child: Container(
                            width: 100.0,
                            height: 5.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).alternate,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add Tags',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineMediumIsCustom,
                                      ),
                                ),
                                Text(
                                  'Select from existing or add new tags below.',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelSmallIsCustom,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 16.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'ADD_TAGS_PERSONAL_VAULT_Icon_fl9m5qm6_ON');
                                logFirebaseEvent('Icon_bottom_sheet');
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close_outlined,
                                color: FlutterFlowTheme.of(context).error,
                                size: 38.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Tags',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: TextFormField(
                                    controller: _model.textController,
                                    focusNode: _model.textFieldFocusNode,
                                    onFieldSubmitted: (_) async {
                                      logFirebaseEvent(
                                          'ADD_TAGS_PERSONAL_VAULT_TextField_gnyrh5');
                                      logFirebaseEvent(
                                          'TextField_update_component_state');
                                      _model.isSimilarTag =
                                          functions.isTagSimilar(
                                              containerUserPersonalVaultRecordList
                                                  .toList(),
                                              _model.textController.text);
                                      safeSetState(() {});
                                    },
                                    autofocus: false,
                                    textCapitalization: TextCapitalization.none,
                                    textInputAction: TextInputAction.done,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Add a New Tag',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelLargeFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelLargeIsCustom,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8.0, 4.0, 0.0, 4.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelMediumIsCustom,
                                        ),
                                    minLines: 1,
                                    maxLength: 16,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    buildCounter: (context,
                                            {required currentLength,
                                            required isFocused,
                                            maxLength}) =>
                                        null,
                                    validator: _model.textControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [
                                      if (!isAndroid && !isiOS)
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          return TextEditingValue(
                                            selection: newValue.selection,
                                            text: newValue.text
                                                .toCapitalization(
                                                    TextCapitalization.none),
                                          );
                                        }),
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z0-9]'))
                                    ],
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 12.0,
                                  borderWidth: 1.0,
                                  buttonSize: 50.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).primary,
                                  icon: Icon(
                                    Icons.add,
                                    color: FlutterFlowTheme.of(context).info,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'ADD_TAGS_PERSONAL_VAULT_add_ICN_ON_TAP');
                                    if (!functions.isTagSimilar(
                                        containerUserPersonalVaultRecordList
                                            .toList(),
                                        _model.textController.text)) {
                                      logFirebaseEvent(
                                          'IconButton_update_component_state');
                                      _model.addToAddedTags(
                                          _model.textController.text);
                                      safeSetState(() {});
                                    }
                                    logFirebaseEvent(
                                        'IconButton_clear_text_fields_pin_codes');
                                    safeSetState(() {
                                      _model.textController?.clear();
                                    });
                                    logFirebaseEvent(
                                        'IconButton_update_component_state');
                                    _model.isSimilarTag = false;
                                    safeSetState(() {});
                                  },
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            if (_model.isSimilarTag)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 0.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        FFIcons.kalertTriangle,
                                        color: Color(0xFFFA000E),
                                        size: 16.0,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            6.0, 0.0, 50.0, 0.0),
                                        child: Text(
                                          'A similar tag already exists. Please enter a different name without emojis or duplicates.',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFFFF000F),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Existing Tags From Other Folders',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 100.0,
                                child: FlutterFlowChoiceChips(
                                  options: functions
                                      .uniqueTagsGenerator(
                                          containerUserPersonalVaultRecordList
                                              .toList())
                                      .map((label) => ChipData(label))
                                      .toList(),
                                  onChanged: (val) async {
                                    safeSetState(
                                        () => _model.choiceChipsValues = val);
                                    logFirebaseEvent(
                                        'ADD_TAGS_PERSONAL_VAULT_ChoiceChips_pwtf');
                                    logFirebaseEvent(
                                        'ChoiceChips_update_component_state');
                                    _model.addedTags = functions
                                        .listMerger(
                                            _model.choiceChipsValues!.toList(),
                                            _model.addedTags.toList())
                                        .toList()
                                        .cast<String>();
                                    safeSetState(() {});
                                  },
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor: Color(0xFFBBDEFB),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelMediumIsCustom,
                                        ),
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    iconSize: 18.0,
                                    elevation: 4.0,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor: Color(0xFFE3F2FD),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelSmallIsCustom,
                                        ),
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    iconSize: 18.0,
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  chipSpacing: 8.0,
                                  rowSpacing: 8.0,
                                  multiselect: true,
                                  initialized: _model.choiceChipsValues != null,
                                  alignment: WrapAlignment.spaceBetween,
                                  controller:
                                      _model.choiceChipsValueController ??=
                                          FormFieldController<List<String>>(
                                    widget.fileRef?.tags,
                                  ),
                                  wrapped: true,
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: Text(
                                'Added Tags',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelMediumIsCustom,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 8.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                height: 70.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Builder(
                                    builder: (context) {
                                      final tagsAttached =
                                          _model.addedTags.toList();

                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children:
                                              List.generate(tagsAttached.length,
                                                  (tagsAttachedIndex) {
                                            final tagsAttachedItem =
                                                tagsAttached[tagsAttachedIndex];
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 4.0, 8.0, 4.0),
                                              child: Container(
                                                height: 25.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFD6E4FF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        tagsAttachedItem,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMediumIsCustom,
                                                                ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'ADD_TAGS_PERSONAL_VAULT_Icon_mctwde1d_ON');
                                                            logFirebaseEvent(
                                                                'Icon_update_component_state');
                                                            _model.removeFromAddedTags(
                                                                tagsAttachedItem);
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            FFIcons.kcloseMD,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            size: 18.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 4.0)),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).divide(SizedBox(width: 8.0)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'ADD_TAGS_PERSONAL_VAULT_ATTACH_TAGS_BTN_');
                          if (_model.addedTags.isNotEmpty) {
                            logFirebaseEvent('Button_backend_call');

                            await widget.fileRef!.reference.update({
                              ...createUserPersonalVaultRecordData(
                                hasTags: true,
                              ),
                              ...mapToFirestore(
                                {
                                  'tags': _model.addedTags,
                                },
                              ),
                            });
                          }
                          logFirebaseEvent('Button_bottom_sheet');
                          Navigator.pop(context);
                        },
                        text: 'Attach Tags',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 50.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                color: FlutterFlowTheme.of(context).info,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                          elevation: 2.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
