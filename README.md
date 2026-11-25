# GSI Installer — Xiaomi Selene

> Automated Generic System Image (GSI) flashing for Xiaomi Redmi 10 / 10 Prime / 10 2022 / Note 11 4G (`selene`) over fastboot.

[![Platform](https://img.shields.io/badge/platform-Windows-0078D4?logo=windows&logoColor=white)](#requirements)
[![Shell](https://img.shields.io/badge/script-batch-4D4D4D)](#usage)
[![Device](https://img.shields.io/badge/device-Xiaomi%20selene-FF6900?logo=xiaomi&logoColor=white)](#requirements)

A single batch script that handles the repetitive part of installing a GSI: disabling vbmeta verification, switching to fastbootd, wiping the old system, flashing the new image to slot A, and rebooting into recovery.

---

## Table of contents

- [Requirements](#requirements)
- [Usage](#usage)
- [What the script does](#what-the-script-does)
- [Warnings](#warnings)
- [Troubleshooting](#troubleshooting)
- [Notes](#notes)
- [Author](#author)

---

## Requirements

| Item | Detail |
| --- | --- |
| Device | Xiaomi `selene` — Redmi 10, Redmi 10 Prime, Redmi 10 2022, Redmi Note 11 4G |
| Bootloader | Unlocked |
| Host OS | Windows with working fastboot drivers |
| Tools | [Android platform-tools](https://developer.android.com/tools/releases/platform-tools) |
| Base ROM | MIUI 12 / MIUI 12.5.12 (China) recommended — tested and most stable |
| Files | A GSI image (`.img`) and the `vbmeta.img` extracted from your **current** MIUI ROM |

> The GSI must be compatible with the device's architecture and partition layout. The script flashes to **slot A** only.

## Usage

1. Download and extract Android platform-tools.
2. Copy `gsi_insteller_seveN.bat` into the platform-tools folder.
3. Boot the phone into fastboot: hold **Volume Down + Power**.
4. Connect the phone over USB and confirm it is detected:

   ```bat
   fastboot devices
   ```

5. Run `gsi_insteller_seveN.bat` — double-click it or right-click → **Run as administrator**.
6. When prompted, drag the **GSI image** into the window and press **Enter**.
7. When prompted again, drag the **vbmeta image** into the window and press **Enter**.
8. Sit back. The script flashes everything automatically and reboots to recovery.
9. In recovery, **wipe data/factory reset**, then reboot to system.

## What the script does

| Step | Command |
| --- | --- |
| Disable verification | `fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img` |
| Enter fastbootd | `fastboot reboot fastboot` |
| Wipe user data | `fastboot erase userdata` |
| Wipe old system | `fastboot erase system` |
| Flash GSI to slot A | `fastboot flash system_a gsi.img` |
| Reboot to recovery | `fastboot reboot recovery` |

## Warnings

- **All data on the device is erased.** Back up anything important first.
- Flashing a GSI can leave the phone unbootable. Keep the stock ROM for your exact model available so you can restore it with MiFlash.
- A mismatched `vbmeta.img` or an incompatible GSI can cause a bootloop — always use the vbmeta from the ROM currently installed.
- Keep the battery above 50% and do not unplug the cable during flashing.
- This script is specific to `selene`. Do not run it on other devices.

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| `fastboot` is not recognized | Run the script from inside the platform-tools folder, or add that folder to `PATH` |
| Device not listed by `fastboot devices` | Install the Xiaomi/Google USB driver and try another cable or port |
| Stuck at `reboot fastboot` | Wait up to a minute; re-run `fastboot devices` and continue manually |
| Bootloop after flashing | Reflash the stock ROM with MiFlash, then retry with a different GSI |
| Share denied / permission errors | Run the script as administrator |

## Notes

- The optional `boot.img` flashing section is disabled in the script by design; enable it only if your GSI requires a matching boot image.
- MIUI 13 works, but the author recommends MIUI 12 / 12.5.12 for better performance with a GSI.
- Commands are interactive by design — always verify `fastboot devices` before starting.

## Author

**Mohamed Refaay** — [@mohammed20033](https://github.com/mohammed20033)

Tested on Xiaomi `selene`. Issues and improvements are welcome.
