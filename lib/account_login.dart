import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountLoginPage extends StatelessWidget {
  final String userEmail;
  final String userId;

  const AccountLoginPage({
    Key? key,
    this.userEmail = 'msurya2543@gmail.com',
    this.userId = 'd9037d72-a679-48db-b1e9-7293bf6818d3',
  }) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF199A8E),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:Colors.white,
          title: Text('Delete Account'),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',style: TextStyle(fontSize: 16,letterSpacing: 0.7),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add delete account logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Account deletion requested'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;
    final contentWidth = isDesktop ? 600.0 : screenWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: contentWidth,
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: isDesktop ? 40 : 24),

              // Google Sign-in Section
              Text(
                'You have signed up with Google:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isDesktop ? 18 : 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              Text(
                userEmail,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: isDesktop ? 16 : 14,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: isDesktop ? 40 : 32),

              // Divider
              Divider(color: Colors.grey[300], thickness: 1),

              SizedBox(height: isDesktop ? 40 : 32),

              // User ID Section
              Text(
                'User ID:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isDesktop ? 18 : 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      userId,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: isDesktop ? 16 : 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () => _copyToClipboard(context, userId),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF199A8E).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.copy_outlined,
                        color: Color(0xFF199A8E),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: isDesktop ? 40 : 32),

              // Divider
              Divider(color: Colors.grey[300], thickness: 1),

              SizedBox(height: isDesktop ? 40 : 32),

              // Delete Account Section
              InkWell(
                onTap: () => _showDeleteAccountDialog(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delete account',
                      style: TextStyle(
                        color: Color(0xFFE91E63),
                        fontSize: isDesktop ? 18 : 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                      Icons.delete_outline,
                      color: Color(0xFFE91E63),
                      size: 28,
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
