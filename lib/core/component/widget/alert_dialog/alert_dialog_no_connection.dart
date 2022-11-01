import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/core/extension/context_extension.dart';
import '../../../constant/design/border_constant.dart';
import '../../../constant/enum/network_result_enum.dart';
import '../../../constant/text/error_text_message.dart';
import '../../../init/network/connection_activity/network_change_manager.dart';

class NoNetworkAlertDialog extends StatefulWidget {
  late bool? isCoverScreen = true;
  NoNetworkAlertDialog({super.key, this.isCoverScreen});

  @override
  State<NoNetworkAlertDialog> createState() => _NoNetworkAlertDialogState();
}

class _NoNetworkAlertDialogState extends State<NoNetworkAlertDialog>
    with StateMixin {
  Timer? timer;
  late EdgeInsets containerPadding = const EdgeInsets.only(bottom: 0);
  late final INetworkChangeManager _networkChange;
  NetworkResult? _networkResult;
  @override
  void initState() {
    super.initState();
    _networkChange = NetworkChangeManager();
    _startContainerAnimation();
    fetchFirstResult();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _networkChange.handleNetworkChange((result) {
        if (kDebugMode) {
          print(result);
        }
        _updateView(result);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void _startContainerAnimation() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      setState(() {
        containerPadding =
            const EdgeInsets.only(bottom: 10, left: 20, right: 20);
      });
      timer?.cancel();
    });
  }

  Future<void> fetchFirstResult() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await _networkChange.checkNetworkInitial();
      _updateView(result);
    });
  }

  void _updateView(NetworkResult result) {
    setState(() {
      _networkResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _networkResult == NetworkResult.off
        ? widget.isCoverScreen == false
            ? AnimatedPadding(
                padding: containerPadding,
                duration: context.lowDuration,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderConstant.instance.radiusAllCircularMin,
                        color: Colors.black54,
                      ),
                      width: context.screenWidth,
                      duration: context.lowDuration,
                      child: Padding(
                        padding: context.paddingLowTopBottom,
                        child: Column(children: [
                          const Icon(
                            Icons.signal_wifi_off,
                            color: Colors.white,
                            size: 25,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              ErrorText
                                  .instance.noConnectionErrorExplanationText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: AlertDialog(
                      backgroundColor: Colors.red,
                      title: Column(children: [
                        const Icon(
                          Icons.signal_wifi_off,
                          color: Colors.white,
                          size: 50,
                        ),
                        Text(
                          ErrorText.instance.noConnectionErrorText,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      content: SizedBox(
                        height: context.screenHeight / 10,
                        width: context.screenWidth / 4,
                        child: Text(
                          ErrorText.instance.noConnectionErrorExplanationText,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          maxLines: null,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderConstant.instance.radiusAllCircularHigh),
                    ),
                  ),
                  const ModalBarrier(),
                ],
              )
        : const Center();
  }
}

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void waitForScreen(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onComplete.call();
    });
  }
}

/*AlertDialog(
backgroundColor: Colors.red,
content: Text("No connection need connection",
style: TextStyle(color: Colors.white),),
title: Icon(Icons.error, color: Colors.white, size: 50,),
shape: RoundedRectangleBorder(
borderRadius: BorderConstant.instance.radiusAllCircularMedium),
actions: [
Row(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Expanded(
child: ElevatedCircularIconButton(
label: Align(alignment: Alignment.center,
child: Text('try again',
style: TextStyle(fontSize: 20, color: Colors.black),
textAlign: TextAlign.center,)),
color: Colors.white,
onPressed: () {
if(_networkResult == NetworkResult.on){
Navigator.pop(context);
}
else{
ToastMessage.instance.errorMessage(errorMessage: "internet yok");
}
},
icon: Icon(Icons.error, color: Colors.red,),
),
),
],
)
],
),*/
