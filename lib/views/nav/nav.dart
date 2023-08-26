import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:z/cubit/navbar_cubit.dart';
import 'package:z/pages/perfilPage.dart';
import 'package:z/pages/powerPage.dart';
import 'package:z/pages/reservas/listar.dart';
import 'package:z/views/nav/custom_bottom_nav_bar_dash.dart';

class PersistentBottonNavBar extends StatefulWidget {
  const PersistentBottonNavBar({super.key});

  @override
  State<PersistentBottonNavBar> createState() => _PersistentBottonNavBarState();
}

class _PersistentBottonNavBarState extends State<PersistentBottonNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavbarCubit(),
      child: BlocConsumer<NavbarCubit, NavbarState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NavbarCubit.get(context);

          Widget currentPage = const Power(); // Valor predeterminado

          switch (cubit.currentIndex) {
            case 0:
              currentPage = const Power();
              break;
            case 1:
              currentPage = const ListarReserva();
              break;
            case 2:
              currentPage = const Perfil();
              break;
          }

          return Scaffold(
            bottomNavigationBar: CustomBottomNavBarDash(
              onChange: (index) {
                cubit.changeBottomNavBar(index);
              },
              defaultSelectedIndex: cubit.currentIndex,
              backgroundColor: Colors.grey.shade100,
              radius: 25,
              showLabel: false,
              textList: const [
                'Home',
                // 'Registrar reserva',
                'Lista de reservas',
                'User',
              ],
              iconList: const [
                Icons.home_outlined,
                // Icons.add_circle_outline,
                Icons.list_alt_outlined,
                Icons.person_outline,
              ],
              selectedColor: Colors.blue, // Ajusta los colores a tu gusto
              unselectedColor: Colors.grey,
            ),
            extendBody: true,
            // body: currentPage,
            body: Container(
              color: Colors.grey.shade300,
              child: currentPage,
            ),
          );
        },
      ),
    );
  }
}
