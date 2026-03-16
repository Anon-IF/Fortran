# 工程应用示例

本目录包含基于《工程分析程序设计》教材的工程计算示例，将前面各章的 Fortran 知识应用于实际工程问题。

---

## 文件列表

| 文件 | 方法 | 应用背景 |
|------|------|----------|
| `newton_method.f90` | 牛顿迭代法 | 求方程 f(x)=0 的根 |
| `gaussian_elim.f90` | 高斯消去法（列主元）| 求解线性方程组 Ax=b |
| `numerical_integration.f90` | 梯形法 + 辛普森法 | 数值定积分 |
| `projectile.f90` | 解析 + 数值模拟 | 抛体运动轨迹 |

---

## 各程序说明

### 牛顿迭代法（newton_method.f90）

**问题**：求方程 f(x) = 0 的根，适用于无法直接解析求解的方程。

**迭代公式**：

```
x_(n+1) = x_n - f(x_n) / f'(x_n)
```

**示例**：
- 求 x³ - 2x - 5 = 0 的根（从 x₀=2 开始）
- 求 cos(x) = x 的不动点

---

### 高斯消去法（gaussian_elim.f90）

**问题**：求解 n 元线性方程组 Ax = b。

**特点**：带列主元（partial pivoting），数值稳定。

**示例方程组**：
```
 2x +  y - z =  8
-3x -  y + 2z = -11
-2x +  y + 2z = -3
```
解：x=2, y=3, z=-1

---

### 数值积分（numerical_integration.f90）

**问题**：计算定积分 ∫_a^b f(x) dx，当 f(x) 无解析原函数时特别有用。

| 方法 | 精度阶 | 说明 |
|------|--------|------|
| 梯形法 | O(h²) | 用梯形近似 |
| 辛普森法 | O(h⁴) | 用抛物线近似，精度更高 |

**验证**：∫₀¹ x² dx = 1/3，∫₀^π sin(x) dx = 2

---

### 抛体运动（projectile.f90）

**问题**：给定初速度和角度，计算并输出完整运动轨迹。

**输出**：
- 飞行时间、最大射程、最大高度（理论值）
- 逐步轨迹数据写入 `trajectory.txt`（可用 gnuplot 绘图）

---

## 编译和运行

```bash
# 以牛顿法为例
cd examples
gfortran newton_method.f90 -o newton
./newton

# 带优化的编译（推荐用于生产计算）
gfortran -O2 gaussian_elim.f90 -o gauss
./gauss
```

---

## 延伸练习

1. 修改 `newton_method.f90`，改用**二分法**（bisection method）实现求根，比较两者的收敛速度。
2. 修改 `gaussian_elim.f90`，增加一个函数 `matrix_det`，用高斯消去过程中的主元乘积计算行列式。
3. 在 `numerical_integration.f90` 中增加**龙贝格积分法**（Romberg integration），比较不同方法的精度。
4. 修改 `projectile.f90`，加入空气阻力（阻力与速度平方成正比），用**欧拉法**进行数值积分求解轨迹。
