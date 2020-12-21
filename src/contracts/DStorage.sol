pragma solidity ^0.5.0;

contract DStorage {

  string public name = "DApp dropbox";
  uint public fileCount = 0;

  mapping(uint => File) public files;

  struct File {
    uint fileId;
    string fileHash;
    uint fileSize;
    string fileType;
    string fileName;
    string fileDesc;
    uint uploadTime;
    address payable uploader;
  }

  // Event for when file is uploaded
  event FileUploaded (
    uint fileId,
    string fileHash,
    uint fileSize,
    string fileType,
    string fileName,
    string fileDesc,
    uint uploadTime,
    address payable uploader
  );

  constructor() public {
  }

  function uploadFile(string memory _fileHash, uint _fileSize, string memory _fileType, string memory _fileName, string memory _fileDesc) public {

    // Make sure all inputs exist
    require(bytes(_fileHash).length > 0);
    require(bytes(_fileType).length > 0);
    require(bytes(_fileName).length > 0);
    require(bytes(_fileDesc).length > 0);
    require(_fileSize > 0);    

    // Make sure address exists
    require(msg.sender != address(0));

    // Increment file count
    fileCount = fileCount + 1;

    // Create and add file to files array
    files[fileCount] = File(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDesc, now, msg.sender);

    // Trigger file uploaded event
    emit FileUploaded(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDesc, now, msg.sender);
  }

    

}