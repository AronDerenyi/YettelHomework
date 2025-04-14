# Yettel Homework

## Elindítás
A projekt a [Tuist](https://tuist.dev/)-ot használja projekt generáláshoz.
Ezt több féle módon lehet telepíteni de ajánlom a telepítéshez a
[Mise](https://github.com/jdx/mise?tab=readme-ov-file#install-mise)-t
amivel a következő parancs futtatásával fel is kerül a Tuist:

```bash
mise install tuist
```

Ezután meg is lehet nyitni a projektet a

```bash
tuist install
tuist generate
```

parancsokkal. Az alkalmazás indítása előtt el kell indítani a backend-ként szolgáló
docker konténert is amit terminálban az `API` mappába navigálva a

```bash
docker-compose up
```

parancs indít el. Ha a konténer fut és az alkalmazás is megnyílt XCode-ban akkor
el lehet indítani, de jelen formályában csak szimulátorban hiszen a konténerizált
szerver localhost-ban fut amit valós készülék nem ér el.

## Javaslatok

### Design

- A betűtípus nem elérhető ezért a szövegek megjelenése nem egyezik meg pontosan
a design-ban meghatározottakkal.
- Nincs példa a "vásárlás megerősítése" képernyőre országos matricák esetében.
- Nincs példa szerverről érkező vagy adatfeldolgozás közben történő hibákra.
- Nincs design nem szomszédos megyék kiválasztására (figyelmeztetés és megye
színének megváltozása)

### API

- Nincs dokumentáció és sok esetben nem egyértelmű hogyan kéne használni az adatokat.
- A megyék azonosítója jelenleg a hozzá tartozó matrica típusa ami összezavaró és
a jövőben problémát okozhat.
- A vásárlási folyamat végén a fizetéskor a kliens küldi el a vásárlás összegét ami
valós esetben óriási biztonsági hiba.
