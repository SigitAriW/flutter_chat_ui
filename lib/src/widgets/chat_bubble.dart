import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../constants/key_metadata.dart';

class ChatBubble extends StatelessWidget {
  bool currentUserIsAuthor;
  bool replyCurrentUserIsAuthor;
  bool isForwarded;
  types.Message message;

  ChatBubble({
    super.key,
    required this.currentUserIsAuthor,
    required this.replyCurrentUserIsAuthor,
    required this.message,
    this.isForwarded = false,
  });

  Widget _renderReplyMessageBuilder(
    types.Message message,
    bool currentUserIsAuthor,
  ) {
    switch (message.type) {
      case types.MessageType.text:
        final textMessage = message as types.TextMessage;
        return SelectionContainer.disabled(
          child: Text(
            textMessage.text,
            style: TextStyle(
              color: currentUserIsAuthor ? Colors.white : Color(0xFF495057),
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.14,
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _textMessageBuilder() => Container(
        margin: const EdgeInsetsDirectional.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(
              width: 3,
              color: currentUserIsAuthor ? Colors.white : Color(0xFF212529),
            ),
          ),
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectionContainer.disabled(
                            child: Text(
                              replyCurrentUserIsAuthor
                                  ? 'Anda'
                                  : message.repliedMessage?.author.firstName ??
                                      '-',
                              style: TextStyle(
                                color: currentUserIsAuthor
                                    ? Colors.white
                                    : const Color(0xFF212529),
                                fontSize: 14,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          _renderReplyMessageBuilder(
                            message.repliedMessage!,
                            currentUserIsAuthor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _p2PMessageBuilder() {
    final customMsg = message as types.CustomMessage;
    return Container(
      margin: const EdgeInsetsDirectional.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Image.asset(
                  'assets/ic_send_money_msg.png',
                  package: 'flutter_chat_ui',
                  width: 40,
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: SelectionContainer.disabled(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Text(
                        customMsg.metadata?[KeyMetadata.metadataKeyTitle],
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: currentUserIsAuthor
                              ? Colors.white
                              : const Color(0xFF212529),
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Container(
              margin: const EdgeInsets.all(2),
              alignment: Alignment.centerLeft,
              child: SelectionContainer.disabled(
                child: Text(
                  customMsg.metadata?[KeyMetadata.metadataKeySubtitle],
                  style: TextStyle(
                    color: currentUserIsAuthor
                        ? Colors.white
                        : const Color(0xFF212529),
                    fontSize: 24,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.14,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: customMsg.metadata?[KeyMetadata.metadataKeyMediaUrl] !=
                null,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Image.network(
                        customMsg
                            .metadata?[KeyMetadata.metadataKeyMediaUrl] ?? '',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: customMsg.metadata?[KeyMetadata.metadataKeyMediaUrl] !=
                null,
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: SelectionContainer.disabled(
                  child: Text(
                    customMsg.metadata?[KeyMetadata.metadataKeyDescription] ?? '',
                    style: TextStyle(
                      color: currentUserIsAuthor
                          ? Colors.white
                          : const Color(0xFF212529),
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textForwardedMessageBuilder() {
    final textMessage = message as types.TextMessage;
    return Container(
      margin: const EdgeInsetsDirectional.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Image.asset(
                  'assets/ic_forward.png',
                  package: 'flutter_chat_ui',
                  width: 20,
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: SelectionContainer.disabled(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Text(
                        'Diteruskan',
                        style: TextStyle(
                          color: currentUserIsAuthor
                              ? Colors.white
                              : const Color(0xFF212529),
                          fontSize: 14,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Container(
              margin: const EdgeInsets.all(2),
              alignment: Alignment.centerLeft,
              child: SelectionContainer.disabled(
                child: Text(
                  textMessage.text,
                  style: TextStyle(
                    color: currentUserIsAuthor
                        ? Colors.white
                        : const Color(0xFF212529),
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (message.type == types.MessageType.text) {
      if (isForwarded) {
        return _textForwardedMessageBuilder();
      }
      return _textMessageBuilder();
    } else if (message.type == types.MessageType.custom) {
      return _p2PMessageBuilder();
    } else {
      return Container();
    }
  }
}
