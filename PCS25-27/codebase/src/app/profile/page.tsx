"use client";
import { createClient } from "@/utils/supabase/client";
import { useRouter } from "next/navigation";
import React, { useEffect, useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import QRCodeGenerator from "@/components/qrCodeGenerator";
import { Separator } from "@/components/ui/separator";
import { format } from "date-fns";

interface Booking {
  id: string;
  price: number;
  adults: string;
  childrens: string;
  date_of_visit: string;
  monument_name: string;
  created_at: string;
}

const ProfilePage = () => {
  const router = useRouter();
  const [bookings, setBookings] = useState<Booking[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedBooking, setSelectedBooking] = useState<string | null>(null);
  const [openQR, setOpenQR] = useState(false);

  useEffect(() => {
    const fetchBookings = async () => {
      setLoading(true);
      const supabase = createClient();
      const user = await supabase.auth.getUser();

      console.log("User data:", user.data.user?.id);

      if (!user.data.user) {
        router.push("/login");
        return;
      }

      const { data, error } = await supabase
        .from("bookings")
        .select("*")
        .eq("user_id", user.data.user.id);
      console.log("Fetched bookings:", data);
      if (error) {
        console.error("Error fetching bookings:", error);
      } else {
        setBookings(data || []);
      }

      setLoading(false);
    };

    fetchBookings();
  }, [router]);

  const handleShowQR = (bookingId: string) => {
    setSelectedBooking(bookingId);
    setOpenQR(true);
  };

  return (
    <div className="container mx-auto py-8">
      <h1 className="text-4xl font-bold mb-8">My Profile</h1>
      <div className="grid grid-cols-1 gap-8">
        <div>
          <h2 className="text-2xl font-semibold mb-4">My Bookings</h2>
          {loading ? (
            <div className="text-center py-8">Loading your bookings...</div>
          ) : bookings.length === 0 ? (
            <div className="text-center py-8">
              <p className="mb-4">You do not have any bookings yet.</p>
              <Button onClick={() => router.push("/")}>
                Explore Monuments
              </Button>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {bookings.map((booking) => (
                <Card key={booking.id} className="overflow-hidden">
                  <CardHeader className="bg-primary text-white">
                    <CardTitle>{booking.monument_name || "Monument"}</CardTitle>
                  </CardHeader>
                  <CardContent className="pt-4">
                    <div className="space-y-2">
                      <div className="flex justify-between">
                        <span className="font-medium">Date of Visit:</span>
                        <span>
                          {booking.date_of_visit
                            ? format(new Date(booking.date_of_visit), "PPP")
                            : "Not specified"}
                        </span>
                      </div>
                      <Separator />
                      <div className="flex justify-between">
                        <span className="font-medium">Adults:</span>
                        <span>{booking.adults}</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="font-medium">Children:</span>
                        <span>{booking.childrens}</span>
                      </div>
                      <Separator />
                      <div className="flex justify-between">
                        <span className="font-medium">Price:</span>
                        <span>Rs. {booking.price}</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="font-medium">Booking ID:</span>
                        <span className="text-sm truncate max-w-[150px]">
                          {booking.id}
                        </span>
                      </div>

                      <Button
                        variant="secondary"
                        className="w-full mt-4"
                        onClick={() => handleShowQR(booking.id)}
                      >
                        Show Ticket QR Code
                      </Button>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* QR Code Dialog */}
      <Dialog open={openQR} onOpenChange={setOpenQR}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>Booking QR Code</DialogTitle>
            <DialogDescription>
              Show this QR code at the entrance of the monument
            </DialogDescription>
          </DialogHeader>
          <div className="flex justify-center items-center py-6">
            {selectedBooking && <QRCodeGenerator bookingID={selectedBooking} />}
          </div>
          <Button
            type="button"
            onClick={() => {
              setOpenQR(false);
            }}
          >
            Close
          </Button>
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default ProfilePage;
