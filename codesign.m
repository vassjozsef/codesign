#include <Security/Security.h>

static void printKeys(const void* key, const void* value, void* context) {
  CFShow(key);
}

int main(int argc, const char** argv) {

  CFStringRef str = CFStringCreateWithCString(kCFAllocatorDefault, "/Applications/Discord.app", kCFStringEncodingMacRoman);
  CFURLRef path = CFURLCreateWithString(kCFAllocatorDefault, str, NULL);

  SecStaticCodeRef codeRef;
  OSStatus status = SecStaticCodeCreateWithPath(path, kSecCSDefaultFlags, &codeRef);
  printf("SecStaticCodeCreateWithPath status: %d\n", status);

  SecCSFlags flags = kSecCSInternalInformation | kSecCSSigningInformation | kSecCSRequirementInformation | kSecCSInternalInformation;

  CFDictionaryRef api;
  status = SecCodeCopySigningInformation(codeRef, flags, &api);
  printf("SecCodeCopySigningInformation status: %d\n", status);

  if (!CFDictionaryGetValue(api, kSecCodeInfoIdentifier)) {
    printf("Code is not signed\n");
    return 0;
  }

  CFShow(CFDictionaryGetValue(api, kSecCodeInfoIdentifier));
  CFShow(CFDictionaryGetValue(api, kSecCodeInfoMainExecutable));
  CFShow(CFDictionaryGetValue(api, kSecCodeInfoFormat));

  CFArrayRef certChain = (CFArrayRef)CFDictionaryGetValue(api, kSecCodeInfoCertificates);
  SecCertificateRef cert = (SecCertificateRef)CFArrayGetValueAtIndex(certChain, 0);
  CFShow(cert);

  CFShow(SecCertificateCopySubjectSummary(cert));
  CFStringRef commonName;
  SecCertificateCopyCommonName(cert, &commonName);
  CFShow(commonName);
  CFRelease(commonName);
  
  printf("Keys\n");
  CFDictionaryApplyFunction(api, printKeys, NULL);
}
