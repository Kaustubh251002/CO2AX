const CoTax = artifacts.require("CoTax");
const Gov_side = artifacts.require("Gov_side");
const Crowdsale = artifacts.require("Crowdsale");
const Industry_factory = artifacts.require("Industry_factory");

module.exports = function (deployer) {
  deployer.deploy(CoTax).then(()=>{
    return deployer.deploy(Gov_side,CoTax.address);
  }).then(()=>{
    return deployer.deploy(Crowdsale,648,Gov_side.address,CoTax.address);
  }).then(()=>{
    return deployer.deploy(Industry_factory,CoTax.address);
  })
};
