import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  /// 0 = Visa, 1 = Mastercard, 2 = PayPal
  int selectedPaymentMethod = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildPayButton(),
    );
  }

  /// ====================== APP BAR ======================

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        'Payment',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// ====================== BODY ======================

  Widget buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            buildSummaryCard(),
            buildTenantName(),
            buildOwnerNote(),
            const SizedBox(height: 15),
            buildPaymentTitle(),
            const SizedBox(height: 15),
            buildPaymentMethodsRow(),
          ],
        ),
      ),
    );
  }

  /// ====================== SUMMARY CARD ======================

  Widget buildSummaryCard() {
    return Container(
      decoration: _cardDecoration(),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Apartment rental fee',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          buildInfoRow('Occupant', '1 Person'),
          buildInfoRow('Period', '1 Month'),
          buildInfoRow('Month fee', '\$150,00/Month'),
          buildInfoRow('Discount', '\$10'),
          const SizedBox(height: 20),
          const Divider(),
          buildTotalPrice(),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: Colors.black45)),
          Text(value,
              style: const TextStyle(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget buildTotalPrice() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total price',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          '\$140,00',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFF9057),
          ),
        ),
      ],
    );
  }

  /// ====================== TENANT ======================

  Widget buildTenantName() {
    return infoBox(
      title: 'Tenant name',
      value: 'Maria Magdalena Abigail',
      isHint: false,
    );
  }

  Widget buildOwnerNote() {
    return infoBox(
      title: 'Note for owner',
      value: 'Please clean before I go there...',
      isHint: true,
    );
  }

  Widget infoBox({
    required String title,
    required String value,
    required bool isHint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(.5)),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isHint ? Colors.black54 : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  /// ====================== PAYMENT METHODS ======================

  Widget buildPaymentTitle() {
    return const Text(
      'Payment method',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  Widget buildPaymentMethodsRow() {
    return Row(
      children: [
        buildPaymentMethod(0, 'assets/images/visa.png'),
        const SizedBox(width: 10),
        buildPaymentMethod(1, 'assets/images/masterCards.png'),
        const SizedBox(width: 10),
        buildPaymentMethod(2, 'assets/images/paypal.png'),
      ],
    );
  }

  Widget buildPaymentMethod(int index, String imagePath) {
    final bool isSelected = selectedPaymentMethod == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedPaymentMethod = index),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFFF8C52)
                  : const Color(0xFFE0E0E0),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ]
                : [],
          ),
          child: Center(
            child: Image.asset(imagePath, height: 25),
          ),
        ),
      ),
    );
  }

  /// ====================== PAY BUTTON ======================

  Widget buildPayButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
      child: SizedBox(
        height: 56,
        child: Container(
          decoration: gradientDecoration(),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SuccessScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Pay rent',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ====================== DECORATIONS ======================

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 6,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.6),
          blurRadius: 8,
          offset: const Offset(-2, -2),
        ),
      ],
    );
  }

  BoxDecoration gradientDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFF7903A),
          Color(0xFFF15907),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.30),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.35),
          blurRadius: 4,
          offset: const Offset(0, -2),
        ),
      ],
    );
  }
}

/// ====================== SUCCESS SCREEN ======================

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Success rent',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),

            /// SUCCESS ICON
            const SizedBox(
              width: 80,
              height: 80,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(
                    BorderSide(color: Color(0xFFB8956A), width: 3),
                  ),
                ),
                child: Icon(Icons.check, color: Color(0xFFB8956A), size: 40),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'You managed to rent',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'an apartment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const Text(
              'You have successfully rented your',
              style: TextStyle(fontSize: 14, color: Colors.black45),
            ),
            const Text(
              'dream apartment, you can go there on',
              style: TextStyle(fontSize: 14, color: Colors.black45),
            ),
            const Text(
              'the check-in date',
              style: TextStyle(fontSize: 14, color: Colors.black45),
            ),

            const SizedBox(height: 40),

            Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.9),
                    blurRadius: 4,
                    offset: const Offset(-2, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Find another residence',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
        child: SizedBox(
          height: 56,
          child: Container(
            decoration: _successGradient(),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'Back to home',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static BoxDecoration _successGradient() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF7903A), Color(0xFFF15907)],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.30),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }
}
