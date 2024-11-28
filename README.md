# Waypoints

A simple, but customizable waypoints system for your Roblox Game!

# Installation

You can download the latest version from the [Releases](https://github.com/catteched/waypoints/releases) page which you can just easily drag and drop into your game under `StarterPlayer > StarterPlayerScripts`.

# Configuration

Theres already a few defaults in the config file for you, however you can change them to your liking.
You can then find the configuration module under the `waypoints` localscript named `config`.

## Options

| Option              | Type      | Description                                                                                                                                                                                                                  |
| ------------------- | --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `system`            | `table`   | The system(s) that will handle the waypoints. Currently uses the chat system thats included with the system.If you would like to write your own, you can read [this documentation (not available)](#) for the waypoints api. |
| `middlewareSystems` | `table`   | The system(s) mainly used for authenticating. Currently it uses the provided permissions system, however you are free to write your own. You can find the documentation for it [here (not available)](#).                    |
| `permissions`       | `table`   | Specify permissions on who can or cannot use the waypoints, [look here](#permissions) for permission options.                                                                                                                |
| `distancePrefix`    | `string`  | Prefix to add after the distance number.                                                                                                                                                                                     |
| `highlightFade`     | `boolean` | If the highlight should also fade based on the distance from it. (maxFadeDistance also affects this)                                                                                                                         |
| `fadeDistace`       | `number`  | How far until the text should start fading.                                                                                                                                                                                  |
| `maxFadeDistance`   | `number`  | How far until the waypoint condenses its information viewing                                                                                                                                                                 |

## Permissions

Helps specify who can or cannot use the waypoints based on userids and group ranks. They are specified in the `permissions` table in the config module.

There are two types of permission tables you can use:

-   `players`: Specify specific players (via userids) that can use the waypoints.
-   `groups`: Specify groups and what rank(s) can use each waypoint.

### Players

To specify a player, you can use their `userId` as the key, and set the value to true. For example:

```lua
{
    ...
    players = {
        [123456789] = true,
        [987654321] = false, -- This player wouldnt be able to use the waypoints
    }
}
```

### Groups

To specify a group (and the ranks) which can use the waypoints, you would use the `groupId` as the key, and set the value to a table of ranks with different modes stating how it should check the ranks.

```lua
{
    groups = {
        [123456789] = {
            {
                mode = "equals", -- available modes: "equals", "above", "under"
                rank = 255
            },
            {
                mode = "above",
                rank = 100 -- any rank above 100 (non-inclusive). So 101, 102, 103, etc.
                -- however, if you would like to include 100, you'd have to set the value to 99
            },
            {
                mode = "under",
                rank = 100 -- any rank under 100 (non-inclusive). So 99, 98, 97, etc.
            }
        }
    }
}
```

# Usage

Using the built-in chat system provided with the waypoints system, you can use `/waypoints` command to open all waypoints that are available to you. If you would like to show a group of waypoints, you can use `/waypoints <group>` to show only the waypoints in that group. And if you would like to hide the waypoints, you can use `/waypoints hide`.

# Terms of Use

## Guidelines

-   You are allowed to **modify** and **use** the work in either a commercial or non-commercial contexts[^1]
-   However, you're **not allowed to sell** either the **original** or **modified** versions of our products as a standalone works or have them repackaged as your own[^2]
-   You **may redistribute** the **modified version** (not original) for free to others as long it includes the proper attribution.
-   You **must** give proper attribution to **catteched** in accordance to the **CC BY 4.0** License. A minimal attribution must include the original author/creator's name (in which this case is catteched), a link to the original work, a link to the discord server (`https://discord.gg/yATrVSnGSK`), and the **CC BY 4.0** License.

Upon downloading/using our tech, you agree to the following:

-   **Providing** the **proper attribution** as outlined in the **CC BY 4.0 License**
-   **Not** claim the original or modified versions of our works as your own, and to **not resell** them.[^3]

<sub>These terms are **subject to change over time**, but you will be **notified immediately** if that ever so happens. You are also **automatically agreeing** to the new terms **if they do change** as long as you are **currently using our products in your games**. If you wish to **not comply with the new terms**, then you are **prohibited to use our products in your game** and must remove them immediately.</sub>

[^1]: Its fine if you use it to make profit in your own works.
[^2]: Don't resell our products.
[^3]: Basically don't credit them as something that you made without adding any attribution.
