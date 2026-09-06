pkgname=parch-hyprland-cheatsheet
pkgver=1.0
pkgrel=1
pkgdesc="Hyprland Keybind Guide for ParchLinux"
arch=('any')
license=('GPL3')
depends=('quickshell')
source=('cheatsheet.qml' 'run.sh' 'parch-hyprland-cheatsheet.desktop' 'icon.svg')
sha256sums=(
    '8e233cd3b59fa23f1497a92917f4ac65ef28bb4e6d1d9d29a75f7650cecb76c9' 
    'e80be2bb33fe43d2be4ab02b417939755fb1cdcd37114e9764196313b55b7da1'
    '4cb9b0e5552168f636f4700f3521a975b58af8d3fd637667112a1ce8fb539893' 
    '27f25e22f8b67270bb6a4c9661b898ef35a0b470ed3dc9908596cb034a51abb4'
)

package () {

    
    install -dm755 "$pkgdir/opt/$pkgname"

    install -Dm644 "$srcdir/cheatsheet.qml" \
        "$pkgdir/opt/$pkgname/cheatsheet.qml"

    install -Dm755 "$srcdir/run.sh" \
        "$pkgdir/opt/$pkgname/run.sh"
    
    install -Dm644 "$srcdir/parch-hyprland-cheatsheet.desktop" \
        "$pkgdir/usr/share/applications/parch-hyprland-cheatsheet.desktop"

    install -Dm644 "$srcdir/icon.svg" \
        "$pkgdir/opt/$pkgname/icon.svg"
}