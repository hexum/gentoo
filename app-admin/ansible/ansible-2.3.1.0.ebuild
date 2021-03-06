# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils versionator

DESCRIPTION="Model-driven deployment, config management, and command execution framework"
HOMEPAGE="http://ansible.com/"
SRC_URI="http://releases.ansible.com/${PN}/${P}.tar.gz
	https://dev.gentoo.org/~prometheanfire/dist/ansible/ansible-2.3.1.0-pycryptodome.patch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~x64-macos"
IUSE="test"

RDEPEND="
	dev-python/paramiko[${PYTHON_USEDEP}]
	<dev-python/jinja-2.9[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	|| (
		dev-python/pycryptodome[${PYTHON_USEDEP}]
		>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
	)
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	net-misc/sshpass
	virtual/ssh
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.6[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		<dev-python/mock-1.1[${PYTHON_USEDEP}]
		dev-python/passlib[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/unittest2[${PYTHON_USEDEP}]
		dev-vcs/git
	)"

# not included in release tarball
RESTRICT="test"

PATCHES=( "${DISTDIR}/${P}-pycryptodome.patch" )

python_test() {
	nosetests -d -w test/units -v --with-coverage --cover-package=ansible --cover-branches || die
}

python_install_all() {
	distutils-r1_python_install_all

	doman docs/man/man1/*.1
}
