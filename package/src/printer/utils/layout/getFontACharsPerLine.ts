export function getFontACharsPerLine(deviceName: string) {
  if (deviceName.startsWith('TM-m10'))
    return {
      58: 35,
      60: 35,
    };
  if (deviceName.startsWith('TM-m30'))
    return {
      80: 48,
      58: 35,
      60: 35,
    };
  if (deviceName.startsWith('TM-m30II'))
    return {
      80: 42,
      58: 32,
      60: 32,
    };
  if (deviceName.startsWith('TM-P20'))
    return {
      58: 32,
      60: 35,
    };

  if (deviceName.startsWith('TM-P60II'))
    return {
      58: 35,
      60: 36,
    };

  if (deviceName.startsWith('TM-P60'))
    return {
      58: 35,
      60: 35,
    };
  if (deviceName.startsWith('TM-P80'))
    return {
      80: 42,
    };
  if (deviceName.startsWith('TM-T20'))
    return {
      80: 48,
      58: 35,
      60: 35,
    };
  if (deviceName.startsWith('TM-T60'))
    return {
      80: 42,
    };
  if (deviceName.startsWith('TM-T70'))
    return {
      80: 42,
    };
  if (deviceName.startsWith('TM-T81'))
    return {
      80: 42,
    };
  if (deviceName.startsWith('TM-T82'))
    return {
      80: 48,
      58: 35,
      60: 35,
    };
  if (deviceName.startsWith('TM-T83III'))
    return {
      80: 42,
    };
  if (deviceName.startsWith('TM-T83'))
    return {
      80: 42,
    };

  if (deviceName.startsWith('TM-T88'))
    return {
      80: 42,
      58: 30,
      60: 30,
    };
  if (deviceName.startsWith('TM-T90'))
    return {
      80: 42,
      60: 30,
      58: 30,
    };
  if (deviceName.startsWith('TM-T100'))
    return {
      80: 42,
    };
  if (deviceName.startsWith('TM-U220'))
    return {
      80: 35,
      58: 27,
      60: 27,
    };
  if (deviceName.startsWith('TM-U330'))
    return {
      80: 33,
      58: 25,
      60: 25,
    };
  if (deviceName.startsWith('TM-L90'))
    return {
      80: 42,
      58: 30,
      60: 30,
    };
  if (deviceName.startsWith('TM-H6000'))
    return {
      80: 42,
      58: 30,
      60: 30,
    };

  return {
    80: 42,
    58: 30,
    60: 30,
  };
}
