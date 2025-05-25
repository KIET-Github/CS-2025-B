import React from "react";
import { useQRCode } from "next-qrcode";
const QRCodeGenerator = ({ bookingID }: { bookingID: string }) => {
  const { Canvas } = useQRCode();
  return (
    <Canvas
      text={bookingID}
      options={{
        type: "image/jpeg",
        quality: 0.3,
        errorCorrectionLevel: "M",
        margin: 3,
        scale: 4,
        width: 200,
        color: {
          dark: "#010599FF",
          light: "#FFBF60FF",
        },
      }}
    />
  );
};

export default QRCodeGenerator;
