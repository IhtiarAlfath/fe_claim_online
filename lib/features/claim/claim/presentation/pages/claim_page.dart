import 'package:claim_online/core/utils/constant.dart';
import 'package:claim_online/core/utils/function.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim_general/claim_general_bloc.dart';
import 'package:claim_online/features/claim/claim/presentation/widgets/claim_detail_screen.dart';
import 'package:claim_online/features/claim/claim/presentation/widgets/claim_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClaimPage extends StatelessWidget {
  const ClaimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimGeneralBloc, ClaimGeneralState>(
      builder: (context, state) {
        if (state is ClaimGeneralStateClaimSummary) {
          return ClaimScreen();
        } else if (state is ClaimGeneralStateClaimDetail) {
          return ClaimDetailScreen(
            claim: state.dataClaim,
          );
        } else {
          return const LoadingWidget(color: primaryColor);
        }
      },
    );
  }
}
