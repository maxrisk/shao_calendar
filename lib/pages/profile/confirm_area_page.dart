import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/user_service.dart';
import '../../services/area_service.dart';
import '../../widgets/form/form_field.dart';
import '../../widgets/dialogs/index.dart' as custom;
import '../../widgets/dialogs/bottom_sheet_item.dart';
import 'complete_info_page.dart';

class ConfirmAreaPage extends StatefulWidget {
  const ConfirmAreaPage({
    super.key,
    required this.phone,
    required this.code,
    required this.province,
    required this.city,
  });

  final String phone;
  final String code;
  final Map<String, dynamic>? province;
  final Map<String, dynamic>? city;

  @override
  State<ConfirmAreaPage> createState() => _ConfirmAreaPageState();
}

class _ConfirmAreaPageState extends State<ConfirmAreaPage> {
  Map<String, dynamic>? _selectedProvince;
  Map<String, dynamic>? _selectedCity;
  Map<String, dynamic>? _selectedDistrict;
  bool _isLoading = false;
  final _areaService = AreaService();

  @override
  void initState() {
    super.initState();
    _selectedProvince = widget.province;
    _selectedCity = widget.city;
  }

  void showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
      ),
    );
  }

  Future<void> _selectProvince() async {
    final provinces = await _areaService.getProvinces();
    if (!mounted) return;

    custom.BottomSheet.show(
      context: context,
      title: '选择省份',
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: provinces.length,
        itemBuilder: (context, index) {
          final province = provinces[index];
          final name = province['name'] as String;
          return BottomSheetItem(
            title: name,
            selected: province['id'] == _selectedProvince?['id'],
            onTap: () async {
              setState(() {
                _selectedProvince = province;
                _selectedCity = null; // 清空已选择的城市
                _selectedDistrict = null; // 清空已选择的区
              });
              Navigator.pop(context);
              // 自动打开城市选择器
              await _selectCity();
            },
          );
        },
      ),
    );
  }

  Future<void> _selectCity() async {
    if (_selectedProvince == null) {
      showMessage('请先选择省份');
      return;
    }

    final cities = await _areaService.getCities(_selectedProvince!['id']);
    if (!mounted) return;

    custom.BottomSheet.show(
      context: context,
      title: '选择城市',
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          final name = city['name'] as String;
          return BottomSheetItem(
            title: name,
            selected: city['id'] == _selectedCity?['id'],
            onTap: () async {
              setState(() {
                _selectedCity = city;
                _selectedDistrict = null; // 清空已选择的区
              });
              Navigator.pop(context);
              // 自动打开区选择器
              await _selectDistrict();
            },
          );
        },
      ),
    );
  }

  Future<void> _selectDistrict() async {
    if (_selectedProvince == null || _selectedCity == null) {
      showMessage('请先选择省份和城市');
      return;
    }

    final districts = await _areaService.getDistricts(
      _selectedProvince!['id'],
      _selectedCity!['id'],
    );
    if (!mounted) return;

    custom.BottomSheet.show(
      context: context,
      title: '选择区',
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: districts.length,
        itemBuilder: (context, index) {
          final district = districts[index];
          final name = district['name'] as String;
          return BottomSheetItem(
            title: name,
            selected: district['id'] == _selectedDistrict?['id'],
            onTap: () {
              setState(() {
                _selectedDistrict = district;
              });
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  Future<void> _handleNextStep() async {
    if (_isLoading) return;

    if (_selectedProvince == null || _selectedCity == null) {
      showMessage('请选择省份和城市');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userService = context.read<UserService>();

      // 更新用户地区信息
      final success = await userService.updateArea(
        provinceId: _selectedProvince!['id'] as int,
        cityId: _selectedCity!['id'] as int,
        districtId: _selectedDistrict?['id'], // 区是可选的
      );

      if (!mounted) return;

      if (!success) {
        showMessage('更新地区信息失败，请重试');
        return;
      }

      // 检查用户是否已设置出生日期
      final userInfo = userService.userInfo?.userInfo;
      if (userInfo?.birthDate?.isEmpty ?? true) {
        // 未设置出生日期，跳转到完善信息页面
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CompleteInfoPage(),
          ),
        );
      } else {
        // 已设置出生日期，返回首页
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      showMessage('操作失败，请重试');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('确认区域'),
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormItem(
                        label: '所在省份',
                        hint: '请选择省份',
                        description: '选择您所在的省份',
                        icon: Icons.location_on_outlined,
                        type: FormFieldType.select,
                        value: _selectedProvince?['name'],
                        onTap: _selectProvince,
                      ),
                      const SizedBox(height: 16),
                      FormItem(
                        label: '所在城市',
                        hint: '请选择城市',
                        description: '选择您所在的城市',
                        icon: Icons.location_city_outlined,
                        type: FormFieldType.select,
                        value: _selectedCity?['name'],
                        onTap: _selectCity,
                      ),
                      const SizedBox(height: 16),
                      FormItem(
                        label: '所在区',
                        hint: '请选择区',
                        description: '选择您所在的区',
                        icon: Icons.apartment_outlined,
                        type: FormFieldType.select,
                        value: _selectedDistrict?['name'],
                        onTap: _selectDistrict,
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          '＊请选择您所属的区，若省和市不准确也可进行修改',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 底部按钮
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  16 + MediaQuery.of(context).padding.bottom,
                ),
                child: FilledButton(
                  onPressed: _isLoading ? null : _handleNextStep,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          '下一步',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
