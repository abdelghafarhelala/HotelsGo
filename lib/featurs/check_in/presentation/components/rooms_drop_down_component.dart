import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelsco_task/core/resources/app_strings.dart';
import 'package:hotelsco_task/core/utils/app_colors.dart';
import 'package:hotelsco_task/fake_api/fake_api.dart';
import 'package:hotelsco_task/featurs/add_room/presentation/view_models/room_cubit/room_cubit.dart';

class RoomsDropdown extends StatefulWidget {
  const RoomsDropdown({super.key});

  @override
  RoomsDropdownState createState() => RoomsDropdownState();
}

class RoomsDropdownState extends State<RoomsDropdown> {
  Map<String, int>? selectedRooms = roomsApi[0];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: DropdownButtonFormField<Map<String, int>>(
            style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
            dropdownColor: AppColors.whiteColor,
            iconEnabledColor: AppColors.primaryColor,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 25,
            ),
            value: selectedRooms,
            onChanged: (Map<String, int>? value) {
              setState(() {
                selectedRooms = value;
                print(value);
              });
              // changeValuesOfRoomsAndAdultsAndChildren(value, context);

              context.read<RoomCubit>().roomIndex = roomsApi.indexOf(value!);
              context.read<RoomCubit>().seclectedItem = value;
              setState(() {});
            },
            items: roomsApi.map((room) {
              return DropdownMenuItem<Map<String, int>>(
                value: room,
                child: Text(
                    '${room['room']} Room ${room['adults']} Adult Room ${room['children']} Children'),
              );
            }).toList(),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(15),
              hintText: AppStrings.selectRooms,
              hintStyle: TextStyle(color: AppColors.primaryColor, fontSize: 18),
              border: InputBorder.none,
            ),
            isExpanded: true,
          ),
        );
      },
    );
  }

  void changeValuesOfRoomsAndAdultsAndChildren(
      String? value, BuildContext context) {
    if (value?[0] == '1') {
      context.read<RoomCubit>().roomsNum = 1;
    }
    if (value?[7] == '0') {
      context.read<RoomCubit>().adultsNum = 0;
    } else if (value?[7] == '1') {
      context.read<RoomCubit>().adultsNum = 1;
    } else if (value?[7] == '2') {
      context.read<RoomCubit>().adultsNum = 2;
    }
    if (value?[20] == '0') {
      context.read<RoomCubit>().childrenNum = 0;
    } else if (value?[20] == '1') {
      context.read<RoomCubit>().childrenNum = 1;
    } else if (value?[20] == '2') {
      context.read<RoomCubit>().childrenNum = 2;
    }
  }
}
