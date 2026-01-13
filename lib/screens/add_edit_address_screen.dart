import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/address_provider.dart';
import '../models/address_model.dart';

class AddEditAddressScreen extends StatefulWidget {
  final Address? address;

  const AddEditAddressScreen({super.key, this.address});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _line1Controller;
  late TextEditingController _cityController;
  late TextEditingController _pincodeController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.address?.name ?? '');
    _phoneController = TextEditingController(text: widget.address?.phone ?? '');
    _line1Controller = TextEditingController(text: widget.address?.line1 ?? '');
    _cityController = TextEditingController(text: widget.address?.city ?? '');
    _pincodeController = TextEditingController(text: widget.address?.pincode ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _line1Controller.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress() async {
    // Validation
    if (_nameController.text.isEmpty) {
      _showError('Please enter name');
      return;
    }
    if (_phoneController.text.isEmpty || _phoneController.text.length != 10) {
      _showError('Please enter valid 10-digit phone number');
      return;
    }
    if (_line1Controller.text.isEmpty) {
      _showError('Please enter address');
      return;
    }
    if (_cityController.text.isEmpty) {
      _showError('Please enter city');
      return;
    }
    if (_pincodeController.text.isEmpty || _pincodeController.text.length != 6) {
      _showError('Please enter valid 6-digit pincode');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final addressProvider = context.read<AddressProvider>();

      if (widget.address == null) {
        // Add new address
        await addressProvider.addAddress(
          name: _nameController.text,
          phone: _phoneController.text,
          line1: _line1Controller.text,
          city: _cityController.text,
          pincode: _pincodeController.text,
        );
      } else {
        // Update existing address
        await addressProvider.updateAddress(
          addressId: widget.address!.id,
          name: _nameController.text,
          phone: _phoneController.text,
          line1: _line1Controller.text,
          city: _cityController.text,
          pincode: _pincodeController.text,
        );
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      _showError('Error saving address: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFEF1F1), Color(0xFFFEDFDF), Color(0xFFFED3D3)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.red,
              size: 28,
            ),
          ),
          title: Text(
            widget.address == null ? 'Add Address' : 'Edit Address',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name field
                _buildTextField(
                  label: 'Full Name',
                  controller: _nameController,
                  hint: 'Enter your full name',
                ),
                const SizedBox(height: 16),

                // Phone field
                _buildTextField(
                  label: 'Phone Number',
                  controller: _phoneController,
                  hint: 'Enter 10-digit phone number',
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),
                const SizedBox(height: 16),

                // Address line 1
                _buildTextField(
                  label: 'Address',
                  controller: _line1Controller,
                  hint: 'Enter street address',
                  maxLines: 2,
                ),
                const SizedBox(height: 16),

                // City field
                _buildTextField(
                  label: 'City',
                  controller: _cityController,
                  hint: 'Enter city name',
                ),
                const SizedBox(height: 16),

                // Pincode field
                _buildTextField(
                  label: 'Pincode',
                  controller: _pincodeController,
                  hint: 'Enter 6-digit pincode',
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
                const SizedBox(height: 32),

                // Save button
                GestureDetector(
                  onTap: _isLoading ? null : _saveAddress,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: _isLoading ? Colors.grey[300] : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              widget.address == null ? 'Add Address' : 'Update Address',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[400],
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
