import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// `StreamController` manages incoming warings.
///
/// This is used so that only one dialogue window is shown at once, and later
/// alerts are appended to a queue.
final StreamController<AlertDialogueDetail> alertStreamController =
    StreamController<AlertDialogueDetail>();

/// Manages warnings by queuing them and displaying them one at a time.
class AlertDialogueManager extends ChangeNotifier {
  final Queue _alertsQueue = Queue<AlertDialogueDetail>();
  bool _isDialogShowing = false;

  /// Adds an alert to the queue and shows the next warning if available.
  void addAlert(AlertDialogueDetail alert) {
    _alertsQueue.add(alert);
    _showNextAlert();
  }

  /// Shows the next warning in the queue if no dialog is currently showing.
  void _showNextAlert() {
    if (_isDialogShowing) {
      return;
    }

    if (_alertsQueue.isEmpty) {
      _isDialogShowing = false;
      return;
    }

    _isDialogShowing = true;
    final alert = _alertsQueue.removeFirst();
    alertStreamController.add(alert);
  }

  /// Called when a dialog is closed, allowing the next warning to be displayed.
  void onDialogClosed() {
    _isDialogShowing = false;
    _showNextAlert();
  }
}

/// Widget to display the alert dialogue
class AlertDialogue extends StatelessWidget {
  final AlertDialogueDetail alertDialogueDetail;

  const AlertDialogue(this.alertDialogueDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      child: Row(children: [
        alertDialogueDetail.icon,
        const SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Text(alertDialogueDetail.title),
            const SizedBox(
              height: 20,
            ),
            MarkdownBody(data: alertDialogueDetail.body),
          ],
        ),
      ]),
    );
  }
}

/// Parameters:
/// * `PopupType` (enum): The style of popup to display, sets theme
/// * `String` (title): The title
/// * `String` (body): The body, given as a markdown string
class AlertDialogueDetail extends PopupTypeMixin {
  final String title;
  final String body;

  AlertDialogueDetail(super.popupType, super.context, this.title, this.body);
}

/// User friendly enumeration that encapsulates which theme to use.
///
/// `information` - neutral dialogue window theme
/// `warning` - accent dialogue window theme
/// `error` - error dialogue window theme
enum PopupType {
  information,
  warning,
  error,
}

/// Mixin to abstract the icon logic away from the `AlertDialoguePopup`.
///
/// The mixins separates concerns and increases the modularity of the popup
/// class.
abstract class PopupTypeMixin {
  final PopupType popupType;
  final BuildContext context;

  PopupTypeMixin(this.popupType, this.context);

  Icon get icon {
    switch (popupType) {
      case PopupType.warning:
        return const Icon(Icons.warning);
      case PopupType.error:
        return const Icon(Icons.error);
      default:
        return const Icon(Icons.info);
    }
  }

  Color get primaryColor {
    switch (popupType) {
      case PopupType.warning:
        return Theme.of(context).colorScheme.primary;
      case PopupType.error:
        return Theme.of(context).colorScheme.error;
      default:
        return Theme.of(context).colorScheme.tertiary;
    }
  }
}

/// `information`: The dialogue displays some useful information to the user,
/// that they might not have known. Sets dialogue theme to neutral.
mixin InformationPopupMixin {
  Icon get icon => const Icon(Icons.info);
}

/// `warning` The dialogue displays a warning. Sets dialogue theme to accent
/// colours.
mixin WarningPopupMixin {
  Icon get icon => const Icon(Icons.warning);
}

/// `error`: The dialogue displays an error. Sets dialogue theme to use error
/// colours.
mixin ErrorPopupMixin {
  Icon get icon => const Icon(Icons.error);
}
