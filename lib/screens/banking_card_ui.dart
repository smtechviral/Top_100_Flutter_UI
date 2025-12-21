import 'dart:ui';

import 'package:flutter/material.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  int _currentPage = 0;
  late AnimationController headerAnimController;
  AnimationController? fabAnimController;

  final List<CardData> cards = [
    CardData(
      bank: 'Unit',
      balance: '28,450',
      lastDigits: '2246',
      cardType: 'VISA',
      colors: [Color(0xFF667eea), Color(0xFF764ba2), Color(0xFFf093fb)],
      cardHolder: 'JOHN SMITH',
      expiryDate: '12/26',
    ),
    CardData(
      bank: 'Chase',
      balance: '15,320',
      lastDigits: '8891',
      cardType: 'MASTERCARD',
      colors: [Color(0xFFfa709a), Color(0xFFfee140), Color(0xFFfccb90)],
      cardHolder: 'JOHN SMITH',
      expiryDate: '08/27',
    ),
    CardData(
      bank: 'Bank of America',
      balance: '42,180',
      lastDigits: '5532',
      cardType: 'VISA',
      colors: [Color(0xFF30cfd0), Color(0xFF330867), Color(0xFF4facfe)],
      cardHolder: 'JOHN SMITH',
      expiryDate: '03/28',
    ),
  ];

  final List<Transaction> transactions = [
    Transaction(
      name: 'Wesley Moore',
      description: 'Card replenishment',
      amount: '+\$650',
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF667eea),
      time: '10:30 AM',
    ),
    Transaction(
      name: 'Starbucks',
      description: 'Coffee house',
      amount: '-\$24',
      icon: Icons.coffee_rounded,
      color: Color(0xFFfa709a),
      time: '09:15 AM',
    ),
    Transaction(
      name: 'Spotify',
      description: 'Monthly subscription',
      amount: '-\$9',
      icon: Icons.music_note_rounded,
      color: Color(0xFF30cfd0),
      time: 'Yesterday',
    ),
    Transaction(
      name: 'Amazon',
      description: 'Online shopping',
      amount: '-\$156',
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFFf093fb),
      time: 'Yesterday',
    ),
  ];

  @override
  void initState() {
    super.initState();
    headerAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    fabAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    headerAnimController?.dispose();
    fabAnimController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0a0e27),
      body: Stack(
        children: [
          // Animated background circles
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF667eea).withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFfa709a).withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                buildHeader(),
                buildCard(),
                SizedBox(height: 20,),
                buildDot(),
                SizedBox(height: 28,),
                buildRow(),
                SizedBox(height: 32,),
                buildSection(),
                SizedBox(height: 16,),
                buildList()

              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: buildBottomBar(),

      // Animated Bottom Navigation
    );
  }

  buildHeader() {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0, -0.5), end: Offset.zero).animate(
        CurvedAnimation(
          parent: headerAnimController,
          curve: Curves.easeOutCubic,
        ),
      ),
      child: FadeTransition(
        opacity: headerAnimController,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Cards',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Manage your finances',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildHeaderButton(Icons.add_rounded),
                  SizedBox(width: 12),
                  _buildHeaderButton(Icons.notifications_rounded),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCard() {
    return SizedBox(
      height: 240,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              }
              return Center(
                child: SizedBox(
                  height: Curves.easeOut.transform(value) * 240,
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GlassCard(
                cardData: cards[index],
                isActive: _currentPage == index,
              ),
            ),
          );
        },
      ),
    );
  }

  buildDot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        cards.length,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            gradient: _currentPage == index
                ? LinearGradient(colors: [Color(0xFF667eea), Color(0xFFfa709a)])
                : null,
            color: _currentPage != index ? Colors.white.withOpacity(0.3) : null,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  buildRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildAnimatedActionButton(
            Icons.arrow_downward_rounded,
            'Receive',
            Color(0xFF667eea),
            0,
          ),
          _buildAnimatedActionButton(
            Icons.arrow_upward_rounded,
            'Send',
            Color(0xFFfa709a),
            100,
          ),
          _buildAnimatedActionButton(
            Icons.qr_code_scanner_rounded,
            'Scan',
            Color(0xFF30cfd0),
            200,
          ),
          _buildAnimatedActionButton(
            Icons.swap_horiz_rounded,
            'Exchange',
            Color(0xFFf093fb),
            300,
          ),
        ],
      ),
    );
  }

  buildSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF667eea).withOpacity(0.3),
                  Color(0xFFfa709a).withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(Icons.filter_list_rounded, color: Colors.white, size: 18),
                SizedBox(width: 6),
                Text(
                  'Filter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 24),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 400 + (index * 100)),
            curve: Curves.easeOutCubic,
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: TransactionTile(transaction: transactions[index]),
          );
        },
      ),
    );
  }

  buildBottomBar(){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0a0e27).withOpacity(0.0), Color(0xFF0a0e27)],
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: Color(0xFF1a1f3a).withOpacity(0.7),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_rounded, false),
                _buildNavItem(Icons.credit_card_rounded, true),
                _buildNavItem(Icons.bar_chart_rounded, false),
                _buildNavItem(Icons.person_rounded, false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1a1f3a).withOpacity(0.8),
            Color(0xFF2a2f4a).withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  Widget _buildAnimatedActionButton(
    IconData icon,
    String label,
    Color color,
    int delay,
  ) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: isActive ? 16 : 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        gradient: isActive
            ? LinearGradient(colors: [Color(0xFF667eea), Color(0xFFfa709a)])
            : null,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: Colors.white, size: isActive ? 28 : 26),
    );
  }
}

class GlassCard extends StatelessWidget {
  final CardData cardData;
  final bool isActive;

  const GlassCard({Key? key, required this.cardData, required this.isActive})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: cardData.colors[1].withOpacity(0.4),
              blurRadius: 25,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: cardData.colors,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -30,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),

                  // Glass overlay
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                    ),
                  ),

                  // Card content
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                cardData.bank,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.contactless_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '••••  ••••  ••••  ${cardData.lastDigits}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 3,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CARD HOLDER',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      cardData.cardHolder,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'EXPIRES',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      cardData.expiryDate,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  cardData.cardType,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({Key? key, required this.transaction})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1a1f3a).withOpacity(0.6),
            Color(0xFF2a2f4a).withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [transaction.color, transaction.color.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: transaction.color.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(transaction.icon, color: Colors.white, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      transaction.description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' • ${transaction.time}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: transaction.amount.startsWith('+')
                  ? Color(0xFF30cfd0).withOpacity(0.2)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: transaction.amount.startsWith('+')
                    ? Color(0xFF30cfd0).withOpacity(0.3)
                    : Colors.white.withOpacity(0.1),
              ),
            ),
            child: Text(
              transaction.amount,
              style: TextStyle(
                color: transaction.amount.startsWith('+')
                    ? Color(0xFF30cfd0)
                    : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardData {
  final String bank;
  final String balance;
  final String lastDigits;
  final String cardType;
  final List<Color> colors;
  final String cardHolder;
  final String expiryDate;

  CardData({
    required this.bank,
    required this.balance,
    required this.lastDigits,
    required this.cardType,
    required this.colors,
    required this.cardHolder,
    required this.expiryDate,
  });
}

class Transaction {
  final String name;
  final String description;
  final String amount;
  final IconData icon;
  final Color color;
  final String time;

  Transaction({
    required this.name,
    required this.description,
    required this.amount,
    required this.icon,
    required this.color,
    required this.time,
  });
}
