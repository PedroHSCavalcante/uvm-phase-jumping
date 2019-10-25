# Reset Testing with Phase Jumps
 
"Reset testing is a crucial element of functional sign-off for any chip. To perform reset testin in a self-cheking framework, the architectural components of the entire verification environment need to be correctly synchronized to be made aware of the reset condition. When reset is activated, scoreboards, drivers, and monitors need to be tidied up, and the complex stimulus generation needs to be killed gracefully." (HUNTER, 2016)

To exemplify the use of the reset test in a UVM environment, an environment architecture was proposed. See the diagram below.

<p align="center">
<img src="https://github.com/PedroHSCavalcante/uvm-phase-jumping/blob/master/diagram-ph-jump.png" width="500">
</p>

<p align="center">
<img src="https://github.com/PedroHSCavalcante/uvm-phase-jumping/blob/master/uvm-phases.png" width="500">
</p>




#### References
HUNTER,Brian. Advanced UVM. San Bernardino CA, 2016
