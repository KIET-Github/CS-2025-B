"use client";
import React, { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { createClient } from "@/utils/supabase/client";
import { useRouter } from "next/navigation";
import QRScanner from "@/components/qr-scanner";
import TicketDetails from "@/components/ticket-details";
import { AlertCircle, Check, X } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";

interface Booking {
  id: string;
  price: number;
  adults: string;
  childrens: string;
  date_of_visit: string;
  monument_name: string;
  created_at: string;
  is_used: boolean;
  user_id: string;
}

const StaffPage = () => {
  const router = useRouter();
  const [scanning, setScanning] = useState(false);
  const [ticket, setTicket] = useState<Booking | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [confirmDialog, setConfirmDialog] = useState(false);
  const [processing, setProcessing] = useState(false);
  const [success, setSuccess] = useState<boolean | null>(null);
  const [authenticated, setAuthenticated] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const checkStaffAuth = async () => {
      const supabase = createClient();
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (!user) {
        router.push("/login");
        return;
      }

      // In a real app, you would check if the user has staff privileges
      // For now, we'll just authenticate them
      setAuthenticated(true);
      setLoading(false);
    };

    checkStaffAuth();
  }, [router]);

  const handleQRScanned = async (bookingId: string) => {
    setScanning(false);
    setError(null);
    setSuccess(null);

    try {
      const supabase = createClient();
      const { data, error } = await supabase
        .from("bookings")
        .select("*")
        .eq("id", bookingId)
        .single();

      if (error) {
        setError("Failed to find the ticket. Please try again.");
        return;
      }

      if (!data) {
        setError("Invalid ticket. Booking not found.");
        return;
      }

      setTicket(data as Booking);

      // Check if ticket is already used
      if (data.is_used) {
        setError("This ticket has already been used.");
        return;
      }

      setConfirmDialog(true);
    } catch (err) {
      console.error("Error fetching booking:", err);
      setError("An unexpected error occurred. Please try again.");
    }
  };

  const verifyTicket = async () => {
    if (!ticket) return;

    setProcessing(true);
    try {
      const supabase = createClient();
      const { error } = await supabase
        .from("bookings")
        .update({ is_used: true })
        .eq("id", ticket.id);

      if (error) {
        setError("Failed to verify the ticket. Please try again.");
        setSuccess(false);
      } else {
        setSuccess(true);
      }
    } catch (err) {
      console.error("Error verifying ticket:", err);
      setSuccess(false);
    } finally {
      setProcessing(false);
      setConfirmDialog(false);
    }
  };

  const resetScan = () => {
    setTicket(null);
    setError(null);
    setSuccess(null);
    setConfirmDialog(false);
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center h-[80vh]">
        <div className="text-center">
          <h2 className="text-2xl font-bold mb-4">Loading...</h2>
        </div>
      </div>
    );
  }

  if (!authenticated) {
    return (
      <div className="flex items-center justify-center h-[80vh]">
        <div className="text-center">
          <h2 className="text-2xl font-bold mb-4">Access Denied</h2>
          <p>You do not have permission to access this page.</p>
          <Button className="mt-4" onClick={() => router.push("/")}>
            Go Home
          </Button>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-6 max-w-md">
      <h1 className="text-3xl font-bold mb-6 text-center">
        Ticket Verification
      </h1>

      {error && (
        <Alert variant="destructive" className="mb-6">
          <AlertCircle className="h-4 w-4" />
          <AlertTitle>Error</AlertTitle>
          <AlertDescription>{error}</AlertDescription>
        </Alert>
      )}

      {success === true && (
        <Alert className="mb-6 bg-green-50 border-green-500">
          <Check className="h-4 w-4 text-green-500" />
          <AlertTitle>Success</AlertTitle>
          <AlertDescription>
            Ticket has been successfully verified!
          </AlertDescription>
        </Alert>
      )}

      {success === false && (
        <Alert variant="destructive" className="mb-6">
          <X className="h-4 w-4" />
          <AlertTitle>Failed</AlertTitle>
          <AlertDescription>
            Failed to verify ticket. Please try again.
          </AlertDescription>
        </Alert>
      )}

      <Card className="mb-6">
        <CardHeader>
          <CardTitle className="text-center">
            Scan Visitor&apos;s QR Code
          </CardTitle>
        </CardHeader>
        <CardContent>
          {scanning ? (
            <div className="flex flex-col items-center">
              <QRScanner
                onScan={handleQRScanned}
                onStop={() => setScanning(false)}
              />
              <Button
                variant="outline"
                onClick={() => setScanning(false)}
                className="mt-4"
              >
                Cancel Scanning
              </Button>
            </div>
          ) : (
            <div className="flex flex-col items-center">
              <Button onClick={() => setScanning(true)} className="w-full mb-4">
                Start Scanning QR Code
              </Button>
              <p className="text-sm text-muted-foreground text-center">
                Click the button above to start the camera and scan a
                visitor&apos;s QR code
              </p>
            </div>
          )}
        </CardContent>
      </Card>

      {ticket && !confirmDialog && !error && (
        <Card>
          <CardHeader>
            <CardTitle>Ticket Details</CardTitle>
          </CardHeader>
          <CardContent>
            <TicketDetails ticket={ticket} />
            <div className="flex justify-between mt-6">
              <Button variant="outline" onClick={resetScan}>
                Cancel
              </Button>
              <Button onClick={() => setConfirmDialog(true)}>
                Verify Ticket
              </Button>
            </div>
          </CardContent>
        </Card>
      )}

      <Dialog open={confirmDialog} onOpenChange={setConfirmDialog}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle>Confirm Ticket Verification</DialogTitle>
            <DialogDescription>
              Are you sure you want to verify this ticket? This action cannot be
              undone.
            </DialogDescription>
          </DialogHeader>
          {ticket && <TicketDetails ticket={ticket} className="my-4" />}
          <DialogFooter className="flex flex-row space-x-2 sm:space-x-0">
            <Button
              variant="outline"
              onClick={() => setConfirmDialog(false)}
              disabled={processing}
            >
              Cancel
            </Button>
            <Button onClick={verifyTicket} disabled={processing}>
              {processing ? "Processing..." : "Verify Ticket"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default StaffPage;
