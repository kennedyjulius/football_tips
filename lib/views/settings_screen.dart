import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Settings state
  bool _showErrors = true;
  bool _isDarkMode = false;
  bool _showNotifications = true;
  String _selectedLanguage = 'English';
  final _formKey = GlobalKey<FormState>();

  // Error tracking
  final List<String> _errorLog = [];
  int _maxErrorLogSize = 100;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _showErrors = prefs.getBool('showErrors') ?? true;
        _isDarkMode = prefs.getBool('isDarkMode') ?? false;
        _showNotifications = prefs.getBool('showNotifications') ?? true;
        _selectedLanguage = prefs.getString('language') ?? 'English';
        _maxErrorLogSize = prefs.getInt('maxErrorLogSize') ?? 100;
      });
    } catch (e) {
      _logError('Failed to load settings: $e');
    }
  }

  Future<void> _saveSettings() async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('showErrors', _showErrors);
      await prefs.setBool('isDarkMode', _isDarkMode);
      await prefs.setBool('showNotifications', _showNotifications);
      await prefs.setString('language', _selectedLanguage);
      await prefs.setInt('maxErrorLogSize', _maxErrorLogSize);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settings saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      _logError('Failed to save settings: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save settings: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _logError(String error) {
    if (_errorLog.length >= _maxErrorLogSize) {
      _errorLog.removeAt(0);
    }
    _errorLog.add('${DateTime.now()}: $error');
  }

  void _clearErrorLog() {
    setState(() {
      _errorLog.clear();
    });
  }

  void _exportErrorLog() {
    // TODO: Implement error log export functionality
    _logError('Error log export not implemented yet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple.shade800,
                Colors.deepPurple.shade900,
              ],
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            // Error Detection Section
            _buildSectionTitle('Error Detection'),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Show Error Messages'),
                    subtitle: const Text('Display error messages in the app'),
                    value: _showErrors,
                    onChanged: (value) {
                      setState(() {
                        _showErrors = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Maximum Error Log Size'),
                              Text(
                                'Current size: $_maxErrorLogSize',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80.w,
                          child: TextFormField(
                            initialValue: _maxErrorLogSize.toString(),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              final size = int.tryParse(value);
                              if (size == null || size < 1) {
                                return 'Invalid';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              final size = int.tryParse(value);
                              if (size != null && size > 0) {
                                setState(() {
                                  _maxErrorLogSize = size;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // App Settings Section
            _buildSectionTitle('App Settings'),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Enable dark mode theme'),
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Notifications'),
                    subtitle: const Text('Enable push notifications'),
                    value: _showNotifications,
                    onChanged: (value) {
                      setState(() {
                        _showNotifications = value;
                      });
                    },
                  ),
                  ListTile(
                    title: const Text('Language'),
                    subtitle: Text(_selectedLanguage),
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      items: ['English', 'Spanish', 'French', 'German']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedLanguage = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Error Log Section
            if (_showErrors) ...[
              _buildSectionTitle('Error Log'),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_errorLog.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No errors logged'),
                      )
                    else
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 200.h,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: _errorLog.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                _errorLog[index],
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              dense: true,
                            );
                          },
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _clearErrorLog,
                            icon: const Icon(Icons.clear_all),
                            label: const Text('Clear Log'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: _exportErrorLog,
                            icon: const Icon(Icons.upload_file),
                            label: const Text('Export Log'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ElevatedButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade800,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  minimumSize: Size(double.infinity, 48.h),
                ),
                child: const Text('Save Settings'),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.purple.shade800,
        ),
      ),
    );
  }
}
