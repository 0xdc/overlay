# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="olive nle video editor"
HOMEPAGE="https://olivevideoeditor.org"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=dev-qt/qtopengl-5.6
	>=media-libs/openimageio-2.1.12
	>=media-libs/opencolorio-2.0.0
	media-libs/openexr
	>=media-video/ffmpeg-3.0[postproc]

"
RDEPEND="${DEPEND}"
BDEPEND=""
