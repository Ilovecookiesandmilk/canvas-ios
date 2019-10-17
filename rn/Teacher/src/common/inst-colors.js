//
// This file is part of Canvas.
// Copyright (C) 2019-present  Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

// DO NOT EDIT: this file was generated by build-colors.js

const instColors = {
  ash: [ '#8B969E', '#556572', '#8B969E', '#556572' ],
  backgroundAlert: [ '#BF32A4', '#B8309E', '#BF32A4', '#B8309E' ],
  backgroundDanger: [ '#EE0612', '#D01A19', '#EE0612', '#D01A19' ],
  backgroundDark: [ '#8B969E', '#556572', '#C7CDD1', '#C7CDD1' ],
  backgroundDarkest: [ '#2D3B45', '#2D3B45', '#FFFFFF', '#FFFFFF' ],
  backgroundGrouped: [ '#F5F5F5', '#8B969E', '#000000', '#000000' ],
  backgroundGroupedCell: [ '#FFFFFF', '#FFFFFF', '#1C1C1E', '#242426' ],
  backgroundInfo: [ '#008EE2', '#0770A3', '#008EE2', '#0770A3' ],
  backgroundLight: [ '#F5F5F5', '#FFFFFF', '#394B58', '#394B58' ],
  backgroundLightest: [ '#FFFFFF', '#FFFFFF', '#000000', '#000000' ],
  backgroundMedium: [ '#C7CDD1', '#556572', '#556572', '#C7CDD1' ],
  backgroundSuccess: [ '#00AC18', '#127A1B', '#00AC18', '#127A1B' ],
  backgroundWarning: [ '#FC5E13', '#C23C0D', '#FC5E13', '#C23C0D' ],
  barney: [ '#BF32A4', '#B8309E', '#BF32A4', '#B8309E' ],
  borderAlert: [ '#BF32A4', '#B8309E', '#BF32A4', '#B8309E' ],
  borderDanger: [ '#EE0612', '#D01A19', '#EE0612', '#D01A19' ],
  borderDark: [ '#8B969E', '#556572', '#C7CDD1', '#C7CDD1' ],
  borderDarkest: [ '#2D3B45', '#2D3B45', '#FFFFFF', '#FFFFFF' ],
  borderInfo: [ '#008EE2', '#0770A3', '#008EE2', '#0770A3' ],
  borderLight: [ '#F5F5F5', '#FFFFFF', '#394B58', '#394B58' ],
  borderLightest: [ '#FFFFFF', '#FFFFFF', '#000000', '#000000' ],
  borderMedium: [ '#C7CDD1', '#556572', '#556572', '#C7CDD1' ],
  borderSuccess: [ '#00AC18', '#127A1B', '#00AC18', '#127A1B' ],
  borderWarning: [ '#FC5E13', '#C23C0D', '#FC5E13', '#C23C0D' ],
  crimson: [ '#EE0612', '#D01A19', '#EE0612', '#D01A19' ],
  electric: [ '#008EE2', '#0770A3', '#008EE2', '#0770A3' ],
  fire: [ '#FC5E13', '#C23C0D', '#FC5E13', '#C23C0D' ],
  licorice: [ '#2D3B45', '#2D3B45', '#2D3B45', '#2D3B45' ],
  oxford: [ '#394B58', '#394B58', '#394B58', '#394B58' ],
  porcelain: [ '#F5F5F5', '#FFFFFF', '#F5F5F5', '#FFFFFF' ],
  shamrock: [ '#00AC18', '#127A1B', '#00AC18', '#127A1B' ],
  textAlert: [ '#BF32A4', '#B8309E', '#BF32A4', '#B8309E' ],
  textDanger: [ '#EE0612', '#D01A19', '#EE0612', '#D01A19' ],
  textDark: [ '#8B969E', '#556572', '#C7CDD1', '#C7CDD1' ],
  textDarkest: [ '#2D3B45', '#2D3B45', '#FFFFFF', '#FFFFFF' ],
  textInfo: [ '#008EE2', '#0770A3', '#008EE2', '#0770A3' ],
  textLight: [ '#F5F5F5', '#FFFFFF', '#394B58', '#394B58' ],
  textLightest: [ '#FFFFFF', '#FFFFFF', '#000000', '#000000' ],
  textSuccess: [ '#00AC18', '#127A1B', '#00AC18', '#127A1B' ],
  textWarning: [ '#FC5E13', '#C23C0D', '#FC5E13', '#C23C0D' ],
  tiara: [ '#C7CDD1', '#556572', '#C7CDD1', '#556572' ],
  white: [ '#FFFFFF', '#FFFFFF', '#FFFFFF', '#FFFFFF' ],
}

export const updateColors = (colors, style, contrast) => {
  let i = (contrast === 'high' ? 1 : 0) + (style === 'dark' ? 2 : 0)
  for (const name of Object.keys(instColors)) {
    colors[name] = instColors[name][i]
  }
}
