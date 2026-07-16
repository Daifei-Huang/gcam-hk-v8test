# 香港建筑部门高能效设备选择偏好情景说明

## 1. 文件内容

本组文件通过修改建筑终端技术的 `share-weight`，表示从 2030 年开始消费者和机构更加偏好高能效设备。商业建筑（`comm`）与城市住宅建筑（`resid_urban`）分别输出 XML，共 6 个：

- `HK_bld_hieff_E1_gradual_comm.xml`
- `HK_bld_hieff_E1_gradual_resid_urban.xml`
- `HK_bld_hieff_E2_accelerated_comm.xml`
- `HK_bld_hieff_E2_accelerated_resid_urban.xml`
- `HK_bld_hieff_E3_deep_comm.xml`
- `HK_bld_hieff_E3_deep_resid_urban.xml`

## 2. 基准与参数设计

- GCAM 默认的相关普通技术和 `hi-eff` 技术 shareweight 均为 1，因此基准相对权重为 1:1。
- 情景从 2030 年开始，不写入 2025 年，从而保留 2025 年及以前的默认设定。
- 所有模型期均明确写入：2030、2035、……、2100。
- 每一时期保持 `standard shareweight + hi-eff shareweight = 2`，只改变普通技术与高效技术之间的相对选择偏好。
- `share-weight` 是 logit 技术选择中的非价格偏好参数，不是强制市场份额。实际技术份额仍受技术成本、能源价格、效率和 logit exponent 等共同影响。
- 为减少求解风险，E3 中普通技术最低仍保留 0.02，而没有直接设为 0。只有在明确模拟禁售或禁止安装普通效率设备时，才建议将其设为 0。

## 3. 三种情景

| 情景 | 含义 | 2030 高效设备等成本偏好 | 长期高效设备等成本偏好 |
|---|---|---:|---:|
| E1_gradual | 渐进型高效设备偏好 | 55% | 80%（2060–2100） |
| E2_accelerated | 加速型高效设备转型 | 60% | 95%（2055–2100） |
| E3_deep | 深度高效设备普及 | 70% | 99%（2055–2100） |

“等成本偏好”按 `hi-eff shareweight / (standard shareweight + hi-eff shareweight)` 计算，仅用于解释参数强度，并不等同于模型输出的技术市场份额。

## 4. 技术覆盖范围

### 商业建筑

1. `comm cooling / electricity`
   - `air conditioning`
   - `air conditioning hi-eff`
2. `comm heating / gas`
   - `gas furnace`
   - `gas furnace hi-eff`
3. `comm hot water_cooking / gas`
   - `gas water heater`
   - `gas water heater hi-eff`

### 城市住宅建筑

对 `d1` 至 `d10` 十个住宅收入组应用完全相同的轨迹：

1. cooling / electricity：`air conditioning` 与 `air conditioning hi-eff`
2. heating / gas：`gas furnace` 与 `gas furnace hi-eff`
3. heating / refined liquids：`fuel furnace` 与 `fuel furnace hi-eff`
4. hot water_cooking / electricity：`electric resistance water heater` 与对应 `hi-eff`
5. hot water_cooking / gas：`gas water heater` 与对应 `hi-eff`
6. hot water_cooking / refined liquids：`fuel water heater` 与对应 `hi-eff`

## 5. 未覆盖内容

- 不包含 `resid_rural`。
- 不修改没有对应 `hi-eff` 技术的 appliances、lighting、electric furnace、heat pump 等技术。
- 因此，该组情景更准确地表示“高能效空调、供暖和热水设备选择偏好”，而不是所有类型的建筑节能行为。
- 若要表示照明、电器或建筑围护结构节能，应另外修改技术效率、能源投入系数、服务需求或建立对应的高效技术。

## 6. 推荐使用方式

- E1：低强度敏感性情景。
- E2：建议作为主要节能行为/高效设备推广情景。
- E3：高强度敏感性情景，接近高效设备成为事实市场标准。

建议分别检查以下模型输出：建筑终端服务技术份额、建筑终端能源消费、分燃料能源消费、电力需求，以及高效设备偏好是否引起燃料替代或 rebound effect。

## 7. 输入依据

- `A44.globaltech_shrwt.csv`：GCAM 默认建筑技术 shareweight 和普通/高效技术配对。
- `bld_prefer_hieff_appliances_HK.xml`：香港建筑 shareweight 情景的 XML 层级与命名参考。
