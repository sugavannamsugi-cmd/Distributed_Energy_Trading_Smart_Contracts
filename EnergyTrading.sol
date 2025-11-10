// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/// @title Simple Distributed Energy Trading (Demo)
/// @notice Minimal smart contract for peer-to-peer energy offers and purchases.
/// @dev This is a teaching/demo contract and not production-ready.
contract EnergyTrading {
    struct Offer {
        address payable seller;
        uint256 energyWh; // energy in watt-hours
        uint256 priceWei; // price in wei (for entire offer)
        bool active;
    }

    uint256 public nextOfferId;
    mapping(uint256 => Offer) public offers;
    event OfferCreated(uint256 indexed offerId, address indexed seller, uint256 energyWh, uint256 priceWei);
    event OfferCancelled(uint256 indexed offerId);
    event OfferBought(uint256 indexed offerId, address indexed buyer, uint256 amountPaid);

    constructor() {
        nextOfferId = 1;
    }

    /// @notice Create an energy offer
    function createOffer(uint256 energyWh, uint256 priceWei) external {
        require(energyWh > 0, "energyWh must be > 0");
        require(priceWei > 0, "price must be > 0");

        uint256 offerId = nextOfferId++;
        offers[offerId] = Offer(payable(msg.sender), energyWh, priceWei, true);

        emit OfferCreated(offerId, msg.sender, energyWh, priceWei);
    }

    /// @notice Cancel your offer
    function cancelOffer(uint256 offerId) external {
        Offer storage ofr = offers[offerId];
        require(ofr.seller == msg.sender, "only seller");
        require(ofr.active, "not active");
        ofr.active = false;
        emit OfferCancelled(offerId);
    }

    /// @notice Buy an active offer (pay exactly priceWei)
    function buyOffer(uint256 offerId) external payable {
        Offer storage ofr = offers[offerId];
        require(ofr.active, "offer not active");
        require(msg.value == ofr.priceWei, "must pay exact price");

        ofr.active = false;
        // transfer payment to seller
        (bool sent,) = ofr.seller.call{value: msg.value}("");
        require(sent, "transfer failed");

        emit OfferBought(offerId, msg.sender, msg.value);
    }

    /// @notice Get offer details
    function getOffer(uint256 offerId) external view returns (address seller, uint256 energyWh, uint256 priceWei, bool active) {
        Offer storage ofr = offers[offerId];
        return (ofr.seller, ofr.energyWh, ofr.priceWei, ofr.active);
    }
}
