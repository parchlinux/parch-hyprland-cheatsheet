pkgname=parch-hyprland-cheatsheet
pkgver=1.0
pkgrel=1
pkgdesc="Hyprland Keybind Guide for ParchLinux"
arch=('any')
license=('GPL3')
depends=('quickshell')
source=('cheatsheet.qml' 'run.sh' 'parch-hyprland-cheatsheet.desktop')
sha256sums=('2f036ffe4fb83e0e523838ea495b436e52e2e4911957703eeffc67b50594d4d4' 'e80be2bb33fe43d2be4ab02b417939755fb1cdcd37114e9764196313b55b7da1' '98fe3f84bc9cf3d8e33ac93362f7f3ef7c12fecb5dcbac5482690198907ffcbb')

package () {

    
    install -dm755 "$pkgdir/opt/$pkgname"

    install -Dm644 "$srcdir/cheatsheet.qml" \
        "$pkgdir/opt/$pkgname/cheatsheet.qml"

    install -Dm755 "$srcdir/run.sh" \
        "$pkgdir/opt/$pkgname/run.sh"
    
    install -Dm644 "$srcdir/parch-hyprland-cheatsheet.desktop" \
        "$pkgdir/usr/share/applications/parch-hyprland-cheatsheet.desktop"
}