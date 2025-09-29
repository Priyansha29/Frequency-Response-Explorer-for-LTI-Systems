# Frequency Response Explorer (MATLAB App)

An interactive MATLAB application for analyzing and visualizing the **frequency response of discrete-time systems**.  
The app is designed with a clean, professional interface to make it easier for students, researchers, and engineers to understand system behavior in both **transfer function** and **impulse response** form.

---

## 🔹 Features
- **Dual Input Options**  
  - Transfer Function (Numerator/Denominator coefficients)  
  - Impulse Response sequence `h[n]`

- **Automatic Frequency Response Visualization**  
  - Magnitude Response  
  - Phase Response  

- **Interactive Exploration**  
  - Zoom, pan, and rescale directly on the plots  
  - Grid lines for clear readability  

- **Professional UI**  
  - Modern layout with clear labels and organized controls  
  - Minimalist design focusing on usability  

---

## 🔹 How It Works
1. Choose system representation:
   - *Transfer Function (num/den)* → Enter numerator and denominator coefficients.  
   - *Impulse Response (h[n])* → Enter the sequence directly.  

2. Click **Plot Response**.  

3. The app computes the **Discrete-Time Fourier Transform** (via MATLAB’s `freqz`) and plots:  
   - **|H(ω)|** vs. Normalized Frequency  
   - **∠H(ω)** vs. Normalized Frequency  

---

## 🔹 Installation & Usage
1. Download `FreqResponseApp.m` from this repository.  
2. Open MATLAB and run the file.  
3. The application window will launch automatically.  
4. Enter system coefficients → Click **Plot Response** → Explore results.  

---

## 🔹 Demo
<img width="992" height="837" alt="Screenshot 2025-09-29 143732" src="https://github.com/user-attachments/assets/47d46980-b9b3-4fc6-b0fa-c5c5ccd327e7" />

<img width="997" height="845" alt="Screenshot 2025-09-29 143440" src="https://github.com/user-attachments/assets/c836e543-30bc-41aa-b0ad-480aed4067db" />



---

## 🔹 Applications
- Digital Signal Processing (DSP) education  
- Filter design and verification  
- System analysis in communication and control engineering  
- Research demonstrations and student projects  

---

## 🔹 Technologies Used
- MATLAB (R2023a or later recommended)  
- MATLAB App Building (script-based GUI using `uifigure`, `uiaxes`, etc.)  

---

## 🔹 Author
👩‍💻 **Priyansha Gour**  
- Engineering student specializing in **Electronics and Telecommunication (ENTC)**  
- Passionate about DSP, embedded systems, and signal analysis.

---
