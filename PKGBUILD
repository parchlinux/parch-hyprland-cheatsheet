pkgname=parch-hyprland-cheatsheet
pkgver=1.0
pkgrel=1
pkgdesc="Hyprland Keybind Guide for ParchLinux"
arch=('any')
license=('GPL3')
depends=('quickshell')
source=('cheatsheet.qml' 'run.sh' 'parch-hyprland-cheatsheet.desktop' 'icon.svg')
sha256sums=(
    '7d47c830245019a9225ae4a3e36874889e65cd2a7e1e854eab3774ca653605e3' 
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