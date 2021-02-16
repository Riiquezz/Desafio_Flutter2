import 'package:flutte_pokedex/helper/enum.dart';
import 'package:flutte_pokedex/scoped_model/pokemonState.dart';
import 'package:flutte_pokedex/widgets/customWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/colorTheme.dart';
import '../widgets/customWidget.dart';
import 'PokemonList/pokemonListPage.dart';
import 'Types/pokemonMovesPage.dart';

class HomePageBody extends StatefulWidget {
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool isViewAll = false;
  double viewAllHeight = 0;
  bool isSearchFieldEnable = false;
  @override
  void initState() {
    super.initState();
    final state = Provider.of<PokemonState>(context, listen: false);
    state.getPokemonListAsync();
  }

  Widget _searchBox() {
    final state = Provider.of<PokemonState>(
      context,
    );
    return InkWell(
      onTap: () async {
        await showSearch(
            context: context, delegate: PokemonSearch(state.pokemonList));
      },
      child: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(right: 30, top: 30, bottom: 20),
          decoration: BoxDecoration(
              color: Color(0xfff6f6f6),
              borderRadius: BorderRadius.circular(50)),
          child: Row(
            children: <Widget>[
              Icon(Icons.search, color: Colors.grey.shade600),
              SizedBox(
                width: 10,
              ),
              Text('Digite aqui o Pokemon que deseja buscar :)',
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: getFontSize(context, 14)))
            ],
          )),
    );
  }

  Widget _pokedexControlButtons() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: isViewAll ? 0 : 12,
        ),
        _buttonRow('Pokedex', 'Movimentos',
            primary1: Color(0xff4dc2a6),
            secondary1: Color(0xff65d4bc),
            primary2: Color(0xfff77769),
            secondary2: Color(0xfff88a7d)),
        _buttonRow('Habilidades', 'Itens',
            primary1: Color(0xff59a9f4),
            secondary1: Color(0xff6fc1f9),
            primary2: Color(0xffffce4a),
            secondary2: Color(0xffffd858)),
        _buttonRow('Berries', 'Habitats',
            primary1: Color(0xff7b528c),
            secondary1: Color(0xff9569a5),
            primary2: Color(0xffb1726c),
            secondary2: Color(0xffc1877e)),
        SizedBox(
          height: isViewAll ? 0 : 12,
        )
      ],
    );
  }

  Widget _buttonRow(String text1, String text2,
      {Color primary1, Color secondary1, Color primary2, Color secondary2}) {
    return AnimatedContainer(
      curve: Curves.linear,
      duration: Duration(milliseconds: 300),
      height: isViewAll ? 0 : getDimention(context, 120),
      child: Row(
        children: <Widget>[
          _getCategoryCard(text1, primary1, secondary1),
          _getCategoryCard(text2, primary2, secondary2)
        ],
      ),
    );
  }

  _openPage(HomePageButtonEnum pageType) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PokemonMovesPage(
              pagetype: pageType,
            )));
  }

  Widget _getCategoryCard(String title, Color color, Color seondaryColor) {
    return InkWell(
      onTap: () {
        switch (title) {
          case 'Moves':
            _openPage(HomePageButtonEnum.Move);
            return;
          case 'Abilities':
            _openPage(HomePageButtonEnum.Abilitie);
            return;
          case 'Item':
            _openPage(HomePageButtonEnum.Item);
            return;
          case 'Habitats':
            _openPage(HomePageButtonEnum.Habitats);
            return;
          case 'Berries':
            _openPage(HomePageButtonEnum.Berries);
            return;
          default:
            Navigator.of(context).pushNamed('/pokemonList');
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        width: MediaQuery.of(context).size.width / 2 - 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 10,
                offset: Offset(2, 5),
                color: color.withAlpha(100),
                spreadRadius: 0),
            // BoxShadow(blurRadius: 8,offset: Offset(5,-2),color: Color(0xffffffff),spreadRadius:5)
          ],
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(),
                  child: Align(
                      alignment: Alignment.topLeft,
                      heightFactor: 1,
                      widthFactor: 1,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: seondaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(0.0),
                              bottomRight: Radius.circular(40.0),
                              bottomLeft: Radius.circular(0.0),
                            )),
                      )),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getFontSize(context, 16),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          key: Key('list'),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Align(
                          heightFactor: .75,
                          widthFactor: .7,
                          alignment: Alignment.bottomLeft,
                          child: Hero(
                            tag: "pokeball",
                            child: Image.asset(
                              'assets/images/pokeball.png',
                              color: AppColors.pokeballColor,
                              height: getDimention(context, 250),
                            ),
                          ))),
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Qual pokemon',
                          style: TextStyle(
                              fontSize: getFontSize(context, 30),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'você está procurando?',
                          style: TextStyle(
                              fontSize: getFontSize(context, 30),
                              fontWeight: FontWeight.w600),
                        ),
                        _searchBox(),
                        _pokedexControlButtons()
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
