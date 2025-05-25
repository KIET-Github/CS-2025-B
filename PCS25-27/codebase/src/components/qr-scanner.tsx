"use client";
import React, { useState } from "react";
import QrReader from "react-qr-scanner";

interface QRScannerProps {
  onScan: (result: string) => void;
  onStop: () => void;
}

const QRScanner: React.FC<QRScannerProps> = ({ onScan, onStop }) => {
  const [error, setError] = useState<string | null>(null);

  const handleScan = (data: { text: string } | null) => {
    if (data?.text) {
      onScan(data.text);
    }
  };

  const handleError = (err: Error) => {
    setError(`Camera error: ${err.message}`);
    console.error(err);
  };

  return (
    <div className="w-full">
      <div className="relative">
        <QrReader
          delay={300}
          onError={handleError}
          onScan={handleScan}
          constraints={{
            video: { facingMode: "environment" },
          }}
          className="w-full rounded-md overflow-hidden"
          style={{ width: "100%", maxWidth: "350px" }}
        />
        <div className="absolute inset-0 border-2 border-dashed border-primary pointer-events-none"></div>
      </div>

      {error && <p className="text-sm text-red-500 mt-2">{error}</p>}

      <p className="mt-4 text-sm text-center text-muted-foreground">
        Position the QR code within the frame to scan
      </p>
    </div>
  );
};

export default QRScanner;
