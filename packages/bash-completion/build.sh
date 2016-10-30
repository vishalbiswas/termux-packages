TERMUX_PKG_HOMEPAGE=https://github.com/scop/bash-completion
TERMUX_PKG_DESCRIPTION="Programmable completion for the bash shell"
TERMUX_PKG_VERSION=2.4
TERMUX_PKG_SRCURL=https://github.com/scop/bash-completion/releases/download/${TERMUX_PKG_VERSION}/bash-completion-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_FOLDERNAME=bash-completion-${TERMUX_PKG_VERSION}
TERMUX_PKG_DEPENDS="bash"
TERMUX_PKG_PLATFORM_INDEPENDENT=yes

termux_step_post_make_install () {
    # remove Slackware's makepkg completion
    rm "${TERMUX_PREFIX}/share/bash-completion/completions/makepkg"
}
