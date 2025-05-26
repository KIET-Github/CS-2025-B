import React, { useState, useCallback } from "react";
import { useDropzone } from "react-dropzone";
import Image from "next/image";

// INTERNAL IMPORT
import Style from "./DropZone.module.css";
import images from "../../img";

const DropZone = ({
  title,
  heading,
  subHeading,
  name,
  website,
  description,
  royalties,
  fileSize,
  category,
  properties,
  uploadToPinata,
  setImage,
}) => {
  const [fileUrl, setFileUrl] = useState(null);
  const [isUploading, setIsUploading] = useState(false);
  const [error, setError] = useState(null);

  const onDrop = useCallback(
    async (acceptedFiles) => {
      setError(null);
      setIsUploading(true);

      try {
        const url = await uploadToPinata(acceptedFiles[0]);
        setFileUrl(url);
        setImage(url);
      } catch (err) {
        setError("Error uploading file. Please try again.");
      } finally {
        setIsUploading(false);
      }
    },
    [uploadToPinata, setImage]
  );

  const { getRootProps, getInputProps } = useDropzone({
    onDrop,
    accept: "image/*",
    maxSize: 5000000,
  });

  return (
    <div className={Style.DropZone}>
      <div className={Style.DropZone_box} {...getRootProps()}>
        <input {...getInputProps()} />
        <div className={Style.DropZone_box_input}>
          <p>{title}</p>
          <div className={Style.DropZone_box_input_img}>
            <Image
              src={images.upload}
              alt="upload"
              width={100}
              height={100}
              objectFit="contain"
              className={Style.DropZone_box_input_img_img}
            />
          </div>
          <p>{heading}</p>
          <p>{subHeading}</p>
        </div>
      </div>

      {error && <p className={Style.error}>{error}</p>}

      {fileUrl && !isUploading && (
        <aside className={Style.DropZone_box_aside}>
          <div className={Style.DropZone_box_aside_box}>
            <img src={fileUrl} alt="NFT image" width={200} height={200} />

            <div className={Style.DropZone_box_aside_box_preview}>
              <div className={Style.DropZone_box_aside_box_preview_one}>
                <p>
                  <span>NFT Name:</span> {name || ""}
                </p>
                <p className={Style.website}>
                  <span>Website:</span> {website || ""}
                </p>
              </div>

              <div className={Style.DropZone_box_aside_box_preview_two}>
                <p>
                  <span>Description:</span> {description || ""}
                </p>
              </div>

              <div className={Style.DropZone_box_aside_box_preview_three}>
                <p>
                  <span>Royalties:</span> {royalties || ""}
                </p>
                <p>
                  <span>File Size:</span> {fileSize || ""}
                </p>
                <p>
                  <span>Properties:</span> {properties || ""}
                </p>
                <p>
                  <span>Category:</span> {category || ""}
                </p>
              </div>
            </div>
          </div>
        </aside>
      )}

      {isUploading && <p className={Style.uploading}>Uploading...</p>}
    </div>
  );
};

export default React.memo(DropZone);
